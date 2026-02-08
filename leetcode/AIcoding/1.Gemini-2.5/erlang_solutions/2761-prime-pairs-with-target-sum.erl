-module(solution).
-export([prime_pairs_with_target_sum/1]).

prime_pairs_with_target_sum(N) ->
    PrimesSet = sieve(N),
    find_pair(2, N div 2, N, PrimesSet).

sieve(N) ->
    IsPrimeMap = maps:from_list([{I, true} || I <- lists:seq(2, N)]),
    sieve_helper(2, N, IsPrimeMap).

sieve_helper(P, N, IsPrimeMap) when P * P > N ->
    gb_sets:from_list([K || {K, true} <- maps:to_list(IsPrimeMap), K >= 2]).
sieve_helper(P, N, IsPrimeMap) ->
    case maps:get(P, IsPrimeMap, false) of
        true ->
            NewIsPrimeMap = mark_multiples(P * P, P, N, IsPrimeMap),
            sieve_helper(P + 1, N, NewIsPrimeMap);
        false ->
            sieve_helper(P + 1, N, IsPrimeMap)
    end.

mark_multiples(I, P, N, IsPrimeMap) when I > N ->
    IsPrimeMap;
mark_multiples(I, P, N, IsPrimeMap) ->
    NewIsPrimeMap = maps:put(I, false, IsPrimeMap),
    mark_multiples(I + P, P, N, NewIsPrimeMap).

is_prime(Num, PrimesSet) ->
    gb_sets:is_element(Num, PrimesSet).

find_pair(Num1, MaxNum1, N, PrimesSet) when Num1 > MaxNum1 ->
    [-1, -1];
find_pair(Num1, MaxNum1, N, PrimesSet) ->
    case is_prime(Num1, PrimesSet) of
        true ->
            Num2 = N - Num1,
            case is_prime(Num2, PrimesSet) of
                true ->
                    [Num1, Num2];
                false ->
                    find_pair(Num1 + 1, MaxNum1, N, PrimesSet)
            end;
        false ->
            find_pair(Num1 + 1, MaxNum1, N, PrimesSet)
    end.