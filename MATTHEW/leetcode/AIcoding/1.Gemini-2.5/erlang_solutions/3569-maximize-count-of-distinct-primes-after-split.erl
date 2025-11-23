-module(solution).
-export([maximize_distinct_primes/1]).

get_spf_sieve(N_MAX) ->
    SPF = array:new([{size, N_MAX + 1}, {fixed, true}, {default, 0}]),
    SPF1 = array:set(1, 1, SPF), 
    SPF_init = lists:foldl(fun(I, Arr) -> array:set(I, I, Arr) end, SPF1, lists:seq(2, N_MAX)),

    lists:foldl(fun(P, CurrentSPF) ->
        if
            array:get(P, CurrentSPF) =:= P -> 
                lists:foldl(fun(Multiple, AccSPF) ->
                    array:set(Multiple, P, AccSPF)
                end, CurrentSPF, lists:seq(P*P, N_MAX, P)); 
            true -> 
                CurrentSPF
        end
    end, SPF_init, lists:seq(2, N_MAX)).

get_distinct_prime_factors(N, SPF_Array) ->
    get_distinct_prime_factors(N, SPF_Array, sets:new()).

get_distinct_prime_factors(1, _SPF_Array, AccSet) -> AccSet;
get_distinct_prime_factors(N, SPF_Array, AccSet) ->
    PrimeFactor = array:get(N, SPF_Array),
    NewAccSet = sets:add_element(PrimeFactor, AccSet),
    get_distinct_prime_factors(N div PrimeFactor, SPF_Array, NewAccSet).

maximize_distinct_primes(N) ->
    SPF_Array = get_spf_sieve(N),

    MaxCount = lists:foldl(fun(I, CurrentMax) ->
        A = I,
        B = N - I,

        FactorsA = get_distinct_prime_factors(A, SPF_Array),
        FactorsB = get_distinct_prime_factors(B, SPF_Array),

        UnionFactors = sets:union(FactorsA, FactorsB),
        Count = sets:size(UnionFactors),

        max(CurrentMax, Count)
    end, 0, lists:seq(1, N - 1)),
    MaxCount.