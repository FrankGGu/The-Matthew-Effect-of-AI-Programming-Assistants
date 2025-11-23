-module(solved).
-export([sorted_gcd_pairs/2]).

sorted_gcd_pairs(Queries, N) ->
    GCDs = lists:seq(1, N),
    Sorted = lists:sort(GCDs),
    lists:map(fun(Q) -> gcd_pair(Q, Sorted) end, Queries).

gcd_pair(Q, Sorted) ->
    lists:filter(fun(X) -> erlang:element(2, erlang:statistics(gc)) == Q end, Sorted).