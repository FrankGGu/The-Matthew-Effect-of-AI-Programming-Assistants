-module(minimum_area_rectangle_ii).
-export([minAreaRect/1]).

minAreaRect(Points) ->
    Map = maps:from_list([{point_key(P), P} || P <- Points]),
    MinArea = min_area_rect(Points, Map, 1000000),
    if
        MinArea == 1000000 -> -1;
        true -> MinArea
    end.

point_key({X, Y}) -> {X, Y}.

min_area_rect([], _Map, Min) -> Min;
min_area_rect([P1 | Rest], Map, Min) ->
    [P2 | _] = Rest,
    min_area_rect(Rest, Map, min_area_rect_helper(P1, Rest, Map, Min)).

min_area_rect_helper(_P1, [], _Map, Min) -> Min;
min_area_rect_helper(P1, [P2 | Rest], Map, Min) ->
    case is_valid(P1, P2, Map) of
        false -> min_area_rect_helper(P1, Rest, Map, Min);
        true ->
            Area = area(P1, P2, Map),
            min(Area, min_area_rect_helper(P1, Rest, Map, Min))
    end.

is_valid({X1, Y1}, {X2, Y2}, Map) ->
    case maps:find({X1, Y2}, Map) of
        {ok, _} ->
            case maps:find({X2, Y1}, Map) of
                {ok, _} -> true;
                _ -> false
            end;
        _ -> false
    end.

area({X1, Y1}, {X2, Y2}, Map) ->
    {X3, Y3} = maps:get({X1, Y2}, Map),
    {X4, Y4} = maps:get({X2, Y1}, Map),
    Width = abs(X1 - X2),
    Height = abs(Y1 - Y3),
    Width * Height.

min(A, B) when A < B -> A;
min(_, B) -> B.