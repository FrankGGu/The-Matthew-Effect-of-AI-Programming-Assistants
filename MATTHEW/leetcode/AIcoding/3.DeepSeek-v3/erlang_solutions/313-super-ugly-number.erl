-spec nth_super_ugly_number(N :: integer(), Primes :: [integer()]) -> integer().
nth_super_ugly_number(N, Primes) ->
    K = length(Primes),
    Ugly = array:new(N, {default, 1}),
    Indices = array:new(K, {default, 1}),
    Multipliers = array:from_list(Primes),
    nth_super_ugly_number(2, N, K, Ugly, Indices, Multipliers).

nth_super_ugly_number(I, N, _K, Ugly, _Indices, _Multipliers) when I > N ->
    array:get(N, Ugly);
nth_super_ugly_number(I, N, K, Ugly, Indices, Multipliers) ->
    MinVal = lists:min([array:get(J, Multipliers) * array:get(array:get(J, Indices), Ugly) || J <- lists:seq(1, K)]),
    NewUgly = array:set(I, MinVal, Ugly),
    NewIndices = lists:foldl(fun(J, Acc) ->
        case array:get(J, Multipliers) * array:get(array:get(J, Acc), Ugly) =:= MinVal of
            true -> array:set(J, array:get(J, Acc) + 1, Acc);
            false -> Acc
        end
    end, Indices, lists:seq(1, K)),
    nth_super_ugly_number(I + 1, N, K, NewUgly, NewIndices, Multipliers).