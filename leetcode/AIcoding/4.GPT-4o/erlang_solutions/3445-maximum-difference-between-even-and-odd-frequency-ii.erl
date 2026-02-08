-module(solution).
-export([max_diff/1]).

max_diff(List) ->
    Freqs = lists:foldl(fun(X, Acc) -> lists:keyreplace(X, 1, Acc, {X, 0}) end, lists:map(fun(X) -> {X, 0} end, lists:usort(List)), List),
    Counts = lists:map(fun({K, V}) -> {K, V + 1} end, Freqs),
    Even = lists:filter(fun({_, V}) -> V rem 2 == 0 end, Counts),
    Odd = lists:filter(fun({_, V}) -> V rem 2 == 1 end, Counts),
    EvenSum = lists:foldl(fun({_, V}, Acc) -> Acc + V end, 0, Even),
    OddSum = lists:foldl(fun({_, V}, Acc) -> Acc + V end, 0, Odd),
    EvenSum - OddSum.