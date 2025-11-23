-module(solution).
-export([count_prime_set_bits/2]).

count_prime_set_bits(L, R) ->
    count_prime_set_bits_recursive(L, R, 0).

count_prime_set_bits_recursive(L, R, Acc) when L > R -> Acc;
count_prime_set_bits_recursive(L, R, Acc) ->
    SetBits = count_set_bits(L),
    NewAcc = case is_prime(SetBits) of
                 true -> Acc + 1;
                 false -> Acc
             end,
    count_prime_set_bits_recursive(L + 1, R, NewAcc).

count_set_bits(N) ->
    bit_count(N, 0).

bit_count(0, Acc) -> Acc;
bit_count(N, Acc) ->
    bit_count(N bsr 1, Acc + (N band 1)).

is_prime(2) -> true;
is_prime(3) -> true;
is_prime(5) -> true;
is_prime(7) -> true;
is_prime(11) -> true;
is_prime(13) -> true;
is_prime(17) -> true;
is_prime(19) -> true;
is_prime(_) -> false.