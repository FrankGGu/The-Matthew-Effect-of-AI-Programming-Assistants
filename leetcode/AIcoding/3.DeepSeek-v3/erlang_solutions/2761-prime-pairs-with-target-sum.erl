-spec find_prime_pairs(Target :: integer()) -> [[integer()]].
find_prime_pairs(Target) ->
    Primes = sieve(Target),
    Pairs = find_pairs(Primes, Target),
    lists:sort(Pairs).

sieve(N) ->
    if
        N < 2 -> [];
        true ->
            Sieve = array:new(N + 1, [{default, true}]),
            Sieve1 = array:set(0, false, Sieve),
            Sieve2 = array:set(1, false, Sieve1),
            sieve_helper(2, N, Sieve2)
    end.

sieve_helper(P, N, Sieve) when P * P =< N ->
    case array:get(P, Sieve) of
        true ->
            Sieve1 = mark_multiples(P, P + P, N, Sieve),
            sieve_helper(P + 1, N, Sieve1);
        false ->
            sieve_helper(P + 1, N, Sieve)
    end;
sieve_helper(_, _, Sieve) ->
    lists:filter(fun(X) -> array:get(X, Sieve) end, lists:seq(2, array:size(Sieve) - 1)).

mark_multiples(P, Current, N, Sieve) when Current =< N ->
    Sieve1 = array:set(Current, false, Sieve),
    mark_multiples(P, Current + P, N, Sieve1);
mark_multiples(_, _, _, Sieve) -> Sieve.

find_pairs(Primes, Target) ->
    PrimeSet = sets:from_list(Primes),
    lists:foldl(fun(X, Acc) ->
        Y = Target - X,
        if
            X > Y -> Acc;
            true ->
                case sets:is_element(Y, PrimeSet) of
                    true -> [[X, Y] | Acc];
                    false -> Acc
                end
        end
    end, [], Primes).