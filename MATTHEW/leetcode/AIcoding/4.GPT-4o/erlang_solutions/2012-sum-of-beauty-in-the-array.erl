-module(solution).
-export([sum_beauty/1]).

sum_beauty(Array) ->
    N = length(Array),
    if N < 3 -> 0;
    true ->
        Min = lists:foldl(fun(X, Acc) -> min(X, Acc) end, hd(Array), Array),
        Max = lists:foldl(fun(X, Acc) -> max(X, Acc) end, hd(Array), Array),
        lists:foldl(fun(X, Acc) -> Acc + (X - Min) + (Max - X) end, 0, Array) div 2
    end.