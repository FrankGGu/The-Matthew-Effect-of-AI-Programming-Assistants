-module(solution).
-export([erect_fence/1]).

erect_fence(Points) ->
    N = length(Points),
    if
        N =< 2 -> Points;
        true ->
            SortedPoints = lists:sort(fun({X1, Y1}, {X2, Y2}) ->
                                          if
                                              X1 < X2 -> true;
                                              X1 == X2 -> Y1 < Y2;
                                              true -> false
                                          end
                                  end, Points),

            Lower = build_hull(SortedPoints),
            Upper = build_hull(lists:reverse(SortedPoints)),

            lists:usort(Lower ++ Upper)
    end.

build_hull(Points) ->
    build_hull(Points, []).

build_hull([], Stack) ->
    lists:reverse(Stack);
build_hull([P | Rest], Stack) ->
    NewStack = drop_right_turns(P, Stack),
    build_hull(Rest, [P | NewStack]).

drop_right_turns(P, Stack) ->
    case Stack of
        [Top, SecondTop | Tail] ->
            Orientation = cross_product(SecondTop, Top, P),
            if
                Orientation < 0 -> drop_right_turns(P, [SecondTop | Tail]);
                true -> Stack
            end;
        _ -> Stack
    end.

cross_product({X1, Y1}, {X2, Y2}, {X3, Y3}) ->
    (X2 - X1) * (Y3 - Y1) - (Y2 - Y1) * (X3 - X1).