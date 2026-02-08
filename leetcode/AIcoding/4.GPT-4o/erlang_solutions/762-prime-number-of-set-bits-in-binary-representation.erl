-module(solution).
-export([count_set_bits/1, is_prime/1, prime_set_bits_count/2]).

count_set_bits(N) ->
    count_set_bits(N, 0).

count_set_bits(0, Acc) -> Acc;
count_set_bits(N, Acc) ->
    count_set_bits(N band (N - 1), Acc + 1).

is_prime(1) -> false;
is_prime(N) -> is_prime(N, 2).

is_prime(N, Div) when Div * Div > N -> true;
is_prime(N, Div) ->
    if
        N rem Div == 0 -> false;
        true -> is_prime(N, Div + 1)
    end.

prime_set_bits_count(Low, High) ->
    lists:foldl(fun(X, Acc) -> 
        case is_prime(count_set_bits(X)) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, lists:seq(Low, High)).