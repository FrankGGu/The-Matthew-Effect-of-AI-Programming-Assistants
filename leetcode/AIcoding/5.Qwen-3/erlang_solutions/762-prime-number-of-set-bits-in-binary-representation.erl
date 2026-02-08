-module(prime_number_of_set_bits).
-export([count_prime_set_bits/1]).

count_prime_set_bits(Num) ->
    Count = count_set_bits(Num),
    is_prime(Count).

count_set_bits(0) ->
    0;
count_set_bits(N) ->
    (N band 1) + count_set_bits(N bsr 1).

is_prime(0) -> false;
is_prime(1) -> false;
is_prime(2) -> true;
is_prime(N) when N > 2 ->
    is_prime(N, 2).

is_prime(N, Div) when Div * Div > N ->
    true;
is_prime(N, Div) ->
    case N rem Div of
        0 -> false;
        _ -> is_prime(N, Div + 1)
    end.