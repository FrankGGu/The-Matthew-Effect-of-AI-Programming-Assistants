-module(solution).
-export([split_array_to_make_coprime_products/1]).

get_prime_factors(N, SievePrimes) when N > 1 ->
    get_prime_factors_recursive(N, SievePrimes, []);
get_prime_factors(1, _) ->
    [];
get_prime_factors(N, _) when N < 1 ->
    [].

get_prime_factors_recursive(N, [], Acc) when N > 1 ->
    [N | Acc];
get_prime_factors_recursive(N, [P | RestPrimes], Acc) ->
    if P * P > N ->
        if N > 1 -> [N | Acc] else Acc end;
    true ->
        if N rem P == 0 ->
            NewN = skip_prime_factor(N, P),
            get_prime_factors_recursive(NewN, RestPrimes, [P | Acc]);
        true ->
            get_prime_factors_recursive(N, RestPrimes, Acc)
        end
    end.

skip_prime_factor(N, P) ->
    if N rem P == 0 -> skip_prime_factor(N div P, P);
    true -> N
    end.

sieve(Limit) ->
    IsPrime = array:new([{size, Limit + 1}, {fixed, true}, {default, true}]),
    IsPrime2 = array:set(0, false, IsPrime),
    IsPrime3 = array:set(1, false, IsPrime2),
    sieve_loop(2, Limit, IsPrime3, []).

sieve_loop(P, Limit, IsPrime, Primes) when P * P =< Limit ->
    if array:get(P, IsPrime) ->
        MarkedIsPrime = mark_multiples(P * P, P, Limit, IsPrime),
        sieve_loop(P + 1, Limit, MarkedIsPrime, [P | Primes]);
    true ->
        sieve_loop(P + 1, Limit, IsPrime, Primes)
    end;
sieve_loop(P, Limit, IsPrime, Primes) ->
    collect_remaining_primes(P, Limit, IsPrime, Primes).

mark_multiples(I, P, Limit, IsPrime) when I =< Limit ->
    MarkedIsPrime = array:set(I, false, IsPrime),
    mark_multiples(I + P, P, Limit, MarkedIsPrime);
mark_multiples(_, _, _, IsPrime) ->
    IsPrime.

collect_remaining_primes(P, Limit, IsPrime, Primes) ->
    Acc = Primes,
    collect_remaining_primes_loop(P, Limit, IsPrime, Acc).

collect_remaining_primes_loop(P, Limit, IsPrime, Acc) when P =< Limit ->
    if array:get(P, IsPrime) ->
        collect_remaining_primes_loop(P + 1, Limit, IsPrime, [P | Acc]);
    true ->
        collect_remaining_primes_loop(P + 1, Limit, IsPrime, Acc)
    end;
collect_remaining_primes_loop(_, _, _, Acc) ->
    lists:reverse(Acc).

split_array_to_make_coprime_products(Nums) ->
    N = length(Nums),
    if N =< 1 -> 0; true ->
        MaxVal = 1000000,
        SievePrimes = sieve(trunc(math:sqrt(MaxVal))),

        NumsArray = array:from_list(Nums),

        PrimeFactorMap = maps:new(),
        AllPrimesSet = gb_sets:new(),

        {FinalPrimeFactorMap, FinalAllPrimesSet} =
            lists:foldl(fun(Idx, {AccMap, AccSet}) ->
                Num = array:get(Idx, NumsArray),
                Factors = get_prime_factors(Num, SievePrimes),
                NewAccSet = lists:foldl(fun(P, S) -> gb_sets:add_element(P, S) end, AccSet, Factors),
                NewAccMap = lists:foldl(fun(P, M) ->
                    maps:update_with(P, fun(L) -> [Idx | L] end, [Idx], M)
                end, AccMap, Factors),
                {NewAccMap, NewAccSet}
            end, {PrimeFactorMap, AllPrimesSet}, lists:seq(0, N - 1)),

        FirstOcc = maps:new(),
        LastOcc = maps:new(),

        {FinalFirstOcc, FinalLastOcc} =
            lists:foldl(fun(P, {AccFirst, AccLast}) ->
                Indices = maps:get(P, FinalPrimeFactorMap),
                F = lists:last(Indices),
                L = lists:hd(Indices),
                {maps:put(P, F, AccFirst), maps:put(P, L, AccLast)}
            end, {FirstOcc, LastOcc}, gb_sets:to_list(FinalAllPrimesSet)),

        Count = 0,
        CurrentMaxLastOcc = -1,

        {FinalCount, _} =
            lists:foldl(fun(I, {AccCount, AccMaxLastOcc}) ->
                Num = array:get(I, NumsArray),
                Factors = get_prime_factors(Num, SievePrimes),

                NewMaxLastOcc = lists:foldl(fun(P, Max) ->
                    max(Max, maps:get(P, FinalLastOcc))
                end, AccMaxLastOcc, Factors),

                if NewMaxLastOcc =< I ->
                    {AccCount + 1, NewMaxLastOcc};
                true ->
                    {AccCount, NewMaxLastOcc}
                end
            end, {Count, CurrentMaxLastOcc}, lists:seq(0, N - 2)),
        FinalCount
    end).