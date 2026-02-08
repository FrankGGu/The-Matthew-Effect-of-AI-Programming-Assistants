-module(solution).
-export([max_prime_difference/1]).

-define(MAX_NUM_VAL, 1000000).

generate_sieve_array() ->
    SieveSize = ?MAX_NUM_VAL + 1,

    Sieve = array:from_list(lists:duplicate(SieveSize, true)),

    Sieve1 = array:set(0, false, Sieve),
    Sieve2 = array:set(1, false, Sieve1),

    sieve_loop_array(2, ?MAX_NUM_VAL, Sieve2).

sieve_loop_array(P, MaxVal, Sieve) when P * P =< MaxVal ->
    if
        array:get(P, Sieve) ->
            UpdatedSieve = mark_multiples_sieve_array(P * P, P, MaxVal, Sieve),
            sieve_loop_array(P + 1, MaxVal, UpdatedSieve);
        true ->
            sieve_loop_array(P + 1, MaxVal, Sieve)
    end;
sieve_loop_array(_, _, Sieve) ->
    Sieve.

mark_multiples_sieve_array(I, P, MaxVal, Sieve) when I =< MaxVal ->
    UpdatedSieve = array:set(I, false, Sieve),
    mark_multiples_sieve_array(I + P, P, MaxVal, UpdatedSieve);
mark_multiples_sieve_array(_, _, _, Sieve) ->
    Sieve.

max_prime_difference(Nums) ->
    IsPrimeSieve = generate_sieve_array(),

    find_min_max_prime_indices(Nums, 0, -1, -1, IsPrimeSieve).

find_min_max_prime_indices([], _, First, Last, _) ->
    Last - First;
find_min_max_prime_indices([H|T], CurrentIndex, CurrentFirst, CurrentLast, IsPrimeSieve) ->
    IsPrime = array:get(H, IsPrimeSieve),
    if
        IsPrime ->
            NewFirst = if CurrentFirst == -1 -> CurrentIndex; true -> CurrentFirst end,
            NewLast = CurrentIndex,
            find_min_max_prime_indices(T, CurrentIndex + 1, NewFirst, NewLast, IsPrimeSieve);
        true ->
            find_min_max_prime_indices(T, CurrentIndex + 1, CurrentFirst, CurrentLast, IsPrimeSieve)
    end.