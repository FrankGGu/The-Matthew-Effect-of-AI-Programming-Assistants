-module(solution).
-export([array_pair_sum/1]).

array_pair_sum(Pairs) ->
    Sorted = lists:sort(Pairs),
    lists:sum(lists:map(fun({X, _}) -> X end, lists:sublist(Sorted, 1, length(Sorted) div 2))).