-module(solution).
-export([prime_subtraction_operation/1]).

primes() ->
    [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997].

find_largest_prime_less_than(N, PrimesList) ->
    find_largest_prime_less_than_loop(N, lists:reverse(PrimesList)).

find_largest_prime_less_than_loop(N, [P | Rest]) when P < N ->
    P;
find_largest_prime_less_than_loop(N, [_ | Rest]) ->
    find_largest_prime_less_than_loop(N, Rest);
find_largest_prime_less_than_loop(_N, []) ->
    0. %% Return 0 to indicate no such prime was found (as primes are >= 2).

prime_subtraction_operation(Nums) ->
    Primes = primes(),
    prime_subtraction_operation_loop(Nums, 0, Primes).

prime_subtraction_operation_loop([], _PrevVal, _Primes) ->
    true; %% All elements processed, array is strictly increasing.
prime_subtraction_operation_loop([CurrentNum | Rest], PrevVal, Primes) ->
    %% We need to find a NewCurrentNum such that NewCurrentNum > PrevVal.
    %% NewCurrentNum can be CurrentNum or CurrentNum - P for some prime P.
    %% To maximize chances for subsequent elements, we want to make NewCurrentNum as small as possible
    %% while satisfying NewCurrentNum > PrevVal.

    %% The condition for subtracting a prime P is CurrentNum - P > PrevVal, which implies P < CurrentNum - PrevVal.
    Required_P_Upper_Bound = CurrentNum - PrevVal,

    if Required_P_Upper_Bound =< 1 ->
        %% If CurrentNum - PrevVal <= 1, it means CurrentNum <= PrevVal + 1.
        %% There is no prime P (smallest is 2) such that P < (<=1).
        %% So, no prime can be subtracted while satisfying CurrentNum - P > PrevVal.
        %% We must use CurrentNum as is.
        if CurrentNum =< PrevVal ->
            false; %% CurrentNum is not strictly greater than PrevVal, impossible.
        true ->
            %% CurrentNum must be PrevVal + 1. Use CurrentNum as is.
            prime_subtraction_operation_loop(Rest, CurrentNum, Primes)
        end;
    true -> %% Required_P_Upper_Bound > 1. This means CurrentNum - PrevVal >= 2.
        %% We can potentially subtract a prime.
        %% Find the largest prime P_to_subtract such that P_to_subtract < Required_P_Upper_Bound.
        P_to_subtract = find_largest_prime_less_than(Required_P_Upper_Bound, Primes),
        if P_to_subtract > 0 -> %% A suitable prime was found (P_to_subtract will be >= 2).
            %% Subtract this prime to make CurrentNum as small as possible while still > PrevVal.
            NewPrevVal = CurrentNum - P_to_subtract,
            prime_subtraction_operation_loop(Rest, NewPrevVal, Primes);
        true -> %% No prime P < Required_P_Upper_Bound exists.
               %% This happens if Required_P_Upper_Bound is 2 (no prime < 2).
            %% We cannot subtract any prime and satisfy the condition.
            %% So, we must use CurrentNum as is.
            if CurrentNum =< PrevVal ->
                false; %% CurrentNum is not strictly greater than PrevVal, impossible.
            true ->
                prime_subtraction_operation_loop(Rest, CurrentNum, Primes)
            end
        end
    end.