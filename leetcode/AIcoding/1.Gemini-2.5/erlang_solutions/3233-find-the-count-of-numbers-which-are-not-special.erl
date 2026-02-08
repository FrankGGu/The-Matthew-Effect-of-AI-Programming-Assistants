-module(solution).
-export([count_non_special/2]).

count_non_special(L, R) ->
    MaxPrimeCandidate = erlang:trunc(math:sqrt(R)),
    Primes = sieve(MaxPrimeCandidate),
    SpecialCount = lists:foldl(fun(P, Acc) ->
                                   SpecialNum = P * P,
                                   if
                                       SpecialNum >= L, SpecialNum =< R -> Acc + 1;
                                       true -> Acc
                                   end
                               end, 0, Primes),
    (R - L + 1) - SpecialCount.

sieve(Limit) ->
    if
        Limit < 2 -> [];
        true -> sieve_internal(2, Limit, array:new([{size, Limit + 1}, {fixed, true}, {default, true}]))
    end.

sieve_internal(P, Limit, IsPrimeArray) when P * P =< Limit ->
    NewIsPrimeArray = mark_multiples(P, Limit, IsPrimeArray),
    NextP = find_next_prime(P + 1, Limit, NewIsPrimeArray),
    sieve_internal(NextP, Limit, NewIsPrimeArray);
sieve_internal(_, Limit, IsPrimeArray) ->
    collect_primes(2, Limit, IsPrimeArray, []).

mark_multiples(P, Limit, IsPrimeArray) ->
    mark_multiples_internal(P * P, P, Limit, IsPrimeArray).

mark_multiples_internal(I, P, Limit, IsPrimeArray) when I =< Limit ->
    NewIsPrimeArray = array:set(I, false, IsPrimeArray),
    mark_multiples_internal(I + P, P, Limit, NewIsPrimeArray);
mark_multiples_internal(_, _, _, IsPrimeArray) ->
    IsPrimeArray.

find_next_prime(P, Limit, IsPrimeArray) when P =< Limit ->
    case array:get(P, IsPrimeArray) of
        true -> P;
        false -> find_next_prime(P + 1, Limit, IsPrimeArray)
    end;
find_next_prime(_, _, _) ->
    Limit + 1.

collect_primes(I, Limit, IsPrimeArray, Acc) when I =< Limit ->
    case array:get(I, IsPrimeArray) of
        true -> collect_primes(I + 1, Limit, IsPrimeArray, [I | Acc]);
        false -> collect_primes(I + 1, Limit, IsPrimeArray, Acc)
    end;
collect_primes(_, _, _, Acc) ->
    lists:reverse(Acc).