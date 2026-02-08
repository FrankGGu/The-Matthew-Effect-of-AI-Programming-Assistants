-module(solution).
-export([closestPrimes/2]).

closestPrimes(Left, Right) ->
    MaxN = Right,
    Sieve = gb_array:new(MaxN + 1, {default, true}),
    Sieve01 = gb_array:set(0, false, Sieve),
    SieveInit = gb_array:set(1, false, Sieve01),
    FinalSieve = sieve_loop(2, MaxN, SieveInit),
    PrimesInRange = collect_primes(Left, Right, FinalSieve, []),
    find_closest_pair(PrimesInRange).

sieve_loop(P, MaxN, Sieve) when P * P =< MaxN ->
    case gb_array:get(P, Sieve) of
        true ->
            MarkedSieve = mark_multiples(P * P, P, MaxN, Sieve),
            sieve_loop(P + 1, MaxN, MarkedSieve);
        false ->
            sieve_loop(P + 1, MaxN, Sieve)
    end;
sieve_loop(_P, _MaxN, Sieve) ->
    Sieve.

mark_multiples(I, P, MaxN, Sieve) when I =< MaxN ->
    MarkedSieve = gb_array:set(I, false, Sieve),
    mark_multiples(I + P, P, MaxN, MarkedSieve);
mark_multiples(_I, _P, _MaxN, Sieve) ->
    Sieve.

collect_primes(Current, Right, Sieve, Acc) when Current =< Right ->
    case gb_array:get(Current, Sieve) of
        true ->
            collect_primes(Current + 1, Right, Sieve, [Current | Acc]);
        false ->
            collect_primes(Current + 1, Right, Sieve, Acc)
    end;
collect_primes(_Current, _Right, _Sieve, Acc) ->
    lists:reverse(Acc).

find_closest_pair(Primes) ->
    case length(Primes) of
        L when L < 2 ->
            [-1, -1];
        _ ->
            find_closest_pair_iter(Primes, 1_000_001, -1, -1)
    end.

find_closest_pair_iter([P1, P2 | Rest], MinDiff, ResP1, ResP2) ->
    Diff = P2 - P1,
    case Diff < MinDiff of
        true ->
            find_closest_pair_iter([P2 | Rest], Diff, P1, P2);
        false ->
            find_closest_pair_iter([P2 | Rest], MinDiff, ResP1, ResP2)
    end;
find_closest_pair_iter([_P | []], _MinDiff, ResP1, ResP2) ->
    [ResP1, ResP2];
find_closest_pair_iter([], _MinDiff, ResP1, ResP2) ->
    [ResP1, ResP2].