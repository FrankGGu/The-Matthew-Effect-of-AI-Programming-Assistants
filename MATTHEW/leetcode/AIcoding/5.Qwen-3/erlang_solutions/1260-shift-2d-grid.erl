-module(solution).
-export([shift_grid/2]).

shift_grid(Grid, k) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Total = Rows * Cols,
    K = k rem Total,
    Flatten = lists:flatten(Grid),
    Shifted = lists:split(Total - K, Flatten),
    lists:append(lists:nth(2, Shifted), lists:nth(1, Shifted)),
    NewFlatten = lists:append(lists:nth(2, Shifted), lists:nth(1, Shifted)),
    lists:foldl(fun(_, Acc) -> 
        [lists:sublist(NewFlatten, 1, Cols) | Acc]
    end, [], lists:seq(1, Rows)).