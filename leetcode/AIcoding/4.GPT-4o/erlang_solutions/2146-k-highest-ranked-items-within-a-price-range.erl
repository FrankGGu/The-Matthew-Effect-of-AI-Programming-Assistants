-module(solution).
-export([highest_ranked_items/3]).

highest_ranked_items(Grid, Price, Range) ->
    lists:map(fun({X, Y}) -> {X, Y, element(X+1, lists:nth(Y+1, Grid))} end,
        lists:filter(fun({X, Y}) -> element(X+1, lists:nth(Y+1, Grid)) =< Price end,
            lists:foldl(fun({Row, Col}, Acc) ->
                Acc ++ [{Row, Col} || X <- [Col-1, Col, Col+1], Y <- [Row-1, Row, Row+1], X >= 0, Y >= 0, X < length(Grid), Y < length(Grid)],
                lists:filter(fun({NewX, NewY}) -> NewX =/= Row orelse NewY =/= Col end, Acc)
            end, [], lists:seq(0, length(Grid)-1))),
    lists:filter(fun({_, _, Value}) -> Value >= Price - Range andalso Value =< Price + Range end,
        lists:sort(fun({_, _, V1}, {_, _, V2}) -> V1 > V2 orelse (V1 =:= V2 andalso (X1, Y1) < (X2, Y2)) end,
            lists:map(fun({X, Y, Value}) -> {X, Y, Value} end,
                lists:foldl(fun(X, Acc) -> Acc ++ X end, [], lists:foldl(fun(X, Acc) -> Acc ++ X end, [], lists:seq(0, length(Grid)-1)))))), [])).