-module(solution).
-export([count_numbers_with_non_decreasing_digits/1]).

count_numbers_with_non_decreasing_digits(N) ->
    count_numbers(N, 1).

count_numbers(N, D) when D > N div 10 -> 
    0;
count_numbers(N, D) ->
    count = count_numbers(N, D + 1) + count_digit(N, D),
    count.

count_digit(N, D) ->
    Max = 9 - D + 1,
    Count = Max + 1,
    Count * binomial(Max + D - 1, D).

binomial(N, K) when K > N -> 
    0;
binomial(N, K) when K == 0; K == N -> 
    1;
binomial(N, K) -> 
    binomial(N - 1, K - 1) + binomial(N - 1, K).