-module(solution).
-export([sum_base/2]).

sum_base(N, K) ->
    sum_digits(N, K).

sum_digits(0, _) -> 
    0;
sum_digits(N, K) -> 
    (N rem K) + sum_digits(N div K, K).