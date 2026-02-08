-spec count_prime_set_bits(Left :: integer(), Right :: integer()) -> integer().
count_prime_set_bits(Left, Right) ->
    Primes = sets:from_list([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]),
    lists:foldl(
        fun(N, Acc) ->
            Bits = count_bits(N),
            case sets:is_element(Bits, Primes) of
                true -> Acc + 1;
                false -> Acc
            end
        end,
        0,
        lists:seq(Left, Right)
    ).

count_bits(N) ->
    count_bits(N, 0).

count_bits(0, Acc) -> Acc;
count_bits(N, Acc) ->
    count_bits(N bsr 1, Acc + (N band 1)).