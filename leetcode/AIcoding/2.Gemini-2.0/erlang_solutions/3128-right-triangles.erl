-module(right_triangles).
-export([solve/1]).

solve(Points) ->
    Xs = lists:map(fun({X, _}) -> X end, Points),
    Ys = lists:map(fun({_, Y}) -> Y end, Points),

    XCounts = count(Xs),
    YCounts = count(Ys),

    lists:foldl(
        fun({X, Y}, Acc) ->
            XCount = maps:get(X, XCounts, 0),
            YCount = maps:get(Y, YCounts, 0),
            Acc + (XCount - 1) * (YCount - 1)
        end,
        0,
        Points
    ).

count(List) ->
    lists:foldl(
        fun(Elem, Acc) ->
            case maps:is_key(Elem, Acc) of
                true ->
                    maps:update(Elem, maps:get(Elem, Acc) + 1, Acc);
                false ->
                    maps:put(Elem, 1, Acc)
            end
        end,
        #{},
        List
    ).