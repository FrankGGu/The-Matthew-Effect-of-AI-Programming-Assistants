-module(permutation_sequence).
-export([get_permutation/2]).

get_permutation(N, K) ->
    Lists = lists:seq(1, N),
    get_permutation(Lists, K-1).

get_permutation(_, 0) ->
    lists:flatten([]);
get_permutation(Lists, K) ->
    Len = length(Lists),
    Factorial = factorial(Len - 1),
    Index = K div Factorial,
    Remainder = K rem Factorial,
    [lists:nth(Index + 1, Lists)] ++ get_permutation(lists:delete(lists:nth(Index + 1, Lists), Lists), Remainder).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).