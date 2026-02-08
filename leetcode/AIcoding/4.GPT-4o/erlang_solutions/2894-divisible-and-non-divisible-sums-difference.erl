-module(solution).
-export([divisible_and_non_divisible_sums_difference/2]).

divisible_and_non_divisible_sums_difference(N, K) ->
    DivisibleSum = lists:sum(lists:filter(fun(X) -> X rem K =:= 0 end, lists:seq(1, N))),
    NonDivisibleSum = lists:sum(lists:filter(fun(X) -> X rem K =/= 0 end, lists:seq(1, N))),
    DivisibleSum - NonDivisibleSum.