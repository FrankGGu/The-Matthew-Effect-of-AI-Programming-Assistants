-module(max_min_sums).
-export([max_sum/2, min_sum/2]).

max_sum(List, K) ->
    List1 = lists:sort(>=, List),
    lists:sum(lists:nthtail(0, lists:sublist(List1, K))).

min_sum(List, K) ->
    List1 = lists:sort(<, List),
    lists:sum(lists:nthtail(0, lists:sublist(List1, K))).