-module(solution).
-export([max_xor_for_queries/2]).

max_xor_for_queries(Numbers, Queries) ->
    SortedNumbers = lists:sort(Numbers),
    lists:map(fun(X) -> find_max_xor(SortedNumbers, X) end, Queries).

find_max_xor(Numbers, Query) ->
    lists:max(lists:map(fun(N) -> N bxor Query end, Numbers)).