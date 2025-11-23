-module(solution).
-export([max_pair_sum/1]).

max_pair_sum(List) ->
    Sorted = lists:sort(List),
    PairSum = lists:map(fun(X, Y) -> X + Y end, lists:sublist(Sorted, length(Sorted) div 2), lists:sublist(Sorted, length(Sorted) div 2, length(Sorted))),
    lists:max(PairSum).