-module(solution).
-export([count_k_reducible_numbers/2]).

count_k_reducible_numbers(N, K) ->
    count_k_reducible_numbers(N, K, 0).

count_k_reducible_numbers(0, _, Count) -> Count;
count_k_reducible_numbers(N, K, Count) ->
    case is_k_reducible(N, K) of
        true -> count_k_reducible_numbers(N - 1, K, Count + 1);
        false -> count_k_reducible_numbers(N - 1, K, Count)
    end.

is_k_reducible(N, K) ->
    Steps = reduce_to_zero(N, 0),
    Steps =:= K.

reduce_to_zero(0, Steps) -> Steps;
reduce_to_zero(N, Steps) ->
    D = sum_digits(N),
    reduce_to_zero(N - D, Steps + 1).

sum_digits(0) -> 0;
sum_digits(N) ->
    (N rem 10) + sum_digits(N div 10).