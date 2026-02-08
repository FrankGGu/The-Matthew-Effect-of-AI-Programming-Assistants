-module(solution).
-export([sum_digits/2]).

sum_digits(N, K) ->
    sum_digits(N, K, 0).

sum_digits(0, _, Sum) ->
    Sum;
sum_digits(N, K, Sum) ->
    sum_digits(N div K, K, Sum + (N rem K)).