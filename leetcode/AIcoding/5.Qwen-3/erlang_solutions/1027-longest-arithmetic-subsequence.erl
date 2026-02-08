-module(longest_arithmetic_subsequence).
-export([length_of_longest_arithmetic_subsequence/2]).

length_of_longest_arithmetic_subsequence(Numbers, Difference) ->
    Map = maps:new(),
    lists:foldl(fun(N, Acc) ->
        Prev = N - Difference,
        Count = maps:get(Prev, Acc, 0),
        NewCount = Count + 1,
        maps:put(N, NewCount, Acc)
    end, Map, Numbers).

length_of_longest_arithmetic_subsequence(Numbers) ->
    length_of_longest_arithmetic_subsequence(Numbers, 0).