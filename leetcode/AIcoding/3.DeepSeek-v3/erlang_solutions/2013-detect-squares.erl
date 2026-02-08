-module(detect_squares).

-export([init/0, add/2, count/2]).

-record(point, {x, y}).

init() ->
    ets:new(points, [set, public, named_table]),
    ok.

add([X, Y], _) ->
    Point = #point{x = X, y = Y},
    case ets:lookup(points, Point) of
        [] -> ets:insert(points, {Point, 1});
        [{Point, Count}] -> ets:insert(points, {Point, Count + 1})
    end,
    ok.

count([X, Y], _) ->
    Points = ets:tab2list(points),
    lists:foldl(fun({#point{x = Px, y = Py}, Pcount}, Acc) ->
        if
            Px =/= X, Py =/= Y, abs(Px - X) =:= abs(Py - Y) ->
                case {ets:lookup(points, #point{x = Px, y = Y}),
                      ets:lookup(points, #point{x = X, y = Py})} of
                    {[{_, Count1}], [{_, Count2}]} ->
                        Acc + Pcount * Count1 * Count2;
                    _ ->
                        Acc
                end;
            true ->
                Acc
        end
    end, 0, Points).