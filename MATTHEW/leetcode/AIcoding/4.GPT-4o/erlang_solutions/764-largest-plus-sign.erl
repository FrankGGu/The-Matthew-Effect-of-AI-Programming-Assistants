-module(largest_plus_sign).
-export([order/2]).

order(Grid, n) ->
    MaxOrder = 0,
    N = length(Grid),
    M = length(hd(Grid)),
    Counts = lists:map(fun(_) -> lists:map(fun(_) -> 0 end, lists:seq(1, M)) end, lists:seq(1, N)) end,
    Counts1 = lists:foldl(fun({X, Y}, Acc) ->
        if
            lists:nth(Y, lists:nth(X, Grid)) == 1 ->
                NewCount = min(min(lists:nth(Y, lists:nth(X, Acc)), lists:nth(Y, lists:nth(X - 1, Acc)) + 1),
                               min(lists:nth(X, lists:nth(Y, Acc)), lists:nth(X - 1, lists:nth(Y, Acc)) + 1)),
                lists:mapfun(fun(I) -> lists:mapfun(fun(J) -> if I == X andalso J == Y -> NewCount; true -> lists:nth(J, lists:nth(I, Acc)) end end, lists:seq(1, M)) end, lists:seq(1, N));
                _ -> Acc
        end
    end, Counts, lists:seq(1, N)),

    lists:foreach(fun(Row) ->
        lists:foreach(fun(Cell) ->
            MaxOrder = max(MaxOrder, lists:nth(Cell, lists:nth(Row, Counts1)))
        end, lists:seq(1, M))
    end, lists:seq(1, N)),
    MaxOrder.