-module(solution).
-export([min_operations/1]).

min_operations(S) ->
    Freqs = lists:foldl(fun(C, Acc) -> lists:keystore(C, 1, Acc, {C, 0}) ++ [{C, element(2, lists:keyfind(C, 1, Acc)) + 1}] end, [], S),
    Counts = [element(2, F) || F <- Freqs],
    MinOps = lists:min(Counts),
    lists:sum(lists:map(fun(C) -> C - MinOps end, Counts)).