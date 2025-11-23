-spec count_primes(N :: integer()) -> integer().
count_primes(N) when N =< 2 -> 0;
count_primes(N) ->
    Sieve = array:new(N, {default, true}),
    Sieve1 = array:set(0, false, Sieve),
    Sieve2 = array:set(1, false, Sieve1),
    count_primes_helper(2, N, Sieve2).

count_primes_helper(P, N, Sieve) when P * P >= N ->
    Count = lists:foldl(fun(_, Acc) -> Acc + 1 end, 0, 
                        [I || I <- lists:seq(2, N - 1), array:get(I, Sieve)]),
    Count;
count_primes_helper(P, N, Sieve) ->
    case array:get(P, Sieve) of
        true ->
            Sieve1 = mark_multiples(P, P + P, N, Sieve),
            count_primes_helper(P + 1, N, Sieve1);
        false ->
            count_primes_helper(P + 1, N, Sieve)
    end.

mark_multiples(P, Current, N, Sieve) when Current >= N -> Sieve;
mark_multiples(P, Current, N, Sieve) ->
    Sieve1 = array:set(Current, false, Sieve),
    mark_multiples(P, Current + P, N, Sieve1).