-module(fence).
-export([outer_square/1]).

outer_square(Points) ->
    case Points of
        [] -> [];
        _ ->
            Sorted = lists:sort(Points),
            LeftMost = hd(Sorted),
            RightMost = lists:last(Sorted),
            BottomLeft = find_bottom_left(Sorted),
            TopRight = find_top_right(Sorted),
            ConvexHull = convex_hull(Sorted),
            ConvexHull
    end.

find_bottom_left(Points) ->
    lists:foldl(fun(P, Acc) ->
        case P of
            {X1, Y1} ->
                {X2, Y2} = Acc,
                if
                    Y1 < Y2 -> P;
                    Y1 == Y2 andalso X1 < X2 -> P;
                    true -> Acc
                end
        end
    end, hd(Points), tl(Points)).

find_top_right(Points) ->
    lists:foldl(fun(P, Acc) ->
        case P of
            {X1, Y1} ->
                {X2, Y2} = Acc,
                if
                    Y1 > Y2 -> P;
                    Y1 == Y2 andalso X1 > X2 -> P;
                    true -> Acc
                end
        end
    end, hd(Points), tl(Points)).

convex_hull(Points) ->
    case length(Points) of
        1 -> Points;
        _ ->
            Lower = lower_hull(Points),
            Upper = upper_hull(Points),
            lists:umerge(lists:tl(Lower), lists:tl(Upper))
    end.

lower_hull(Points) ->
    lower_hull(Points, []).

lower_hull([], Result) ->
    Result;
lower_hull([P | Rest], Result) ->
    lower_hull(Rest, add_to_lower(P, Result)).

add_to_lower(P, [P1, P2 | Rest]) ->
    case cross(P1, P2, P) of
        Cross when Cross < 0 ->
            add_to_lower(P, [P1 | Rest]);
        _ ->
            [P1, P2, P | Rest]
    end;
add_to_lower(P, [P1 | Rest]) ->
    [P1, P | Rest];
add_to_lower(P, []) ->
    [P].

upper_hull(Points) ->
    upper_hull(Points, []).

upper_hull([], Result) ->
    Result;
upper_hull([P | Rest], Result) ->
    upper_hull(Rest, add_to_upper(P, Result)).

add_to_upper(P, [P1, P2 | Rest]) ->
    case cross(P1, P2, P) of
        Cross when Cross > 0 ->
            add_to_upper(P, [P1 | Rest]);
        _ ->
            [P1, P2, P | Rest]
    end;
add_to_upper(P, [P1 | Rest]) ->
    [P1, P | Rest];
add_to_upper(P, []) ->
    [P].

cross(A, B, C) ->
    (B#{} - A#{})*(C#{} - A#{}) - (B#{} - A#{})*(C#{} - A#{}).

#{} -> erlang:error(badarg).
#{} -> erlang:error(badarg).