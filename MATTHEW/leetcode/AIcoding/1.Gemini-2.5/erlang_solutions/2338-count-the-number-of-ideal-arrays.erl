-module(solution).
-export([idealArrays/2]).

-define(MOD, 1000000007).

idealArrays(N, MaxValue) ->
    % The maximum exponent for any prime factor of a number <= MaxValue
    % For MaxValue = 10000, 2^13 = 8192, so max_exponent is 13.
    MaxExponent = 13,
    % The maximum value for N in C(N, K) is (max_exponent + N - 1).
    MaxN_for_C = MaxExponent + N - 1,

    % Precompute factorials and inverse factorials modulo MOD
    Facs = build_factorials(MaxN_for_C, ?MOD),
    InvFacs = build_inv_factorials(MaxN_for_C, Facs, ?MOD),

    % Precompute Smallest Prime Factor (SPF) for all numbers up to MaxValue using a sieve
    SpfArr = sieve(MaxValue),

    % Calculate the total number of ideal arrays
    TotalCount = lists:foldl(fun(M, Acc) ->
        Factors = get_prime_factorization(M, SpfArr),
        CurrentCount = lists:foldl(fun({_P, E}, Prod) ->
            % For each prime factor P with exponent E in M,
            % the number of ways to form a non-decreasing sequence of N exponents
            % ending with E is C(E + N - 1, N - 1).
            C_val = nCr(E + N - 1, N - 1, Facs, InvFacs, ?MOD),
            (Prod * C_val) rem ?MOD
        end, 1, Factors),
        (Acc + CurrentCount) rem ?MOD
    end, 0, lists:seq(1, MaxValue)),

    TotalCount.

pow(_Base, 0, _Mod) -> 1;
pow(Base, Exp, Mod) ->
    case Exp rem 2 of
        1 -> (Base * pow(Base, Exp - 1, Mod)) rem Mod;
        _ ->
            HalfPow = pow(Base, Exp div 2, Mod),
            (HalfPow * HalfPow) rem Mod
    end.

inv(N, Mod) ->
    pow(N, Mod - 2, Mod).

nCr(N, R, Facs, InvFacs, Mod) ->
    if R < 0 orelse R > N -> 0;
       true ->
        Num = array:get(N, Facs),
        Den1 = array:get(R, InvFacs),
        Den2 = array:get(N - R, InvFacs),
        (Num * Den1) rem Mod * Den2 rem Mod
    end.

build_factorials(MaxN, Mod) ->
    Facs = array:new({size, MaxN + 1}, 0),
    Facs1 = array:set(0, 1, Facs),
    lists:foldl(fun(I, Arr) ->
        Prev = array:get(I-1, Arr),
        array:set(I, (I * Prev) rem Mod, Arr)
    end, Facs1, lists:seq(1, MaxN)).

build_inv_factorials(MaxN, Facs, Mod) ->
    InvFacs = array:new({size, MaxN + 1}, 0),
    InvFacs_MaxN = array:set(MaxN, inv(array:get(MaxN, Facs), Mod), InvFacs),
    lists:foldl(fun(I, Arr) ->
        NextInv = array:get(I+1, Arr),
        array:set(I, (NextInv * (I + 1)) rem Mod, Arr)
    end, InvFacs_MaxN, lists:seq(MaxN - 1, 0, -1)).

sieve(MaxVal) ->
    Spf = array:new({size, MaxVal + 1}, 0),
    Spf1 = array:set(1, 1, Spf), % SPF of 1 is 1

    lists:foldl(fun(I, Arr) ->
        case array:get(I, Arr) of
            0 -> % I is prime, so its SPF is I
                Arr1 = array:set(I, I, Arr),
                % Mark multiples of I with I as their SPF, if not already marked by a smaller prime
                lists:foldl(fun(J, Arr2) ->
                    if J * I =< MaxVal andalso array:get(J * I, Arr2) == 0 ->
                        array:set(J * I, I, Arr2);
                    true -> Arr2
                    end
                end, Arr1, lists:seq(I, MaxVal div I)); % Iterate through multiples of I
            _ -> Arr % I is not prime, its SPF was already set by a smaller prime
        end
    end, Spf1, lists:seq(2, MaxVal)).

get_prime_factorization(N, SpfArr) ->
    get_prime_factorization_recursive(N, SpfArr, []).

get_prime_factorization_recursive(1, _SpfArr, Acc) -> lists:reverse(Acc);
get_prime_factorization_recursive(N, SpfArr, Acc) ->
    P = array:get(N, SpfArr), % Smallest prime factor of N
    {Count, RemN} = count_prime_factor(N, P, 0), % Count occurrences of P in N
    get_prime_factorization_recursive(RemN, SpfArr, [{P, Count} | Acc]).

count_prime_factor(N, P, Count) ->
    if N rem P == 0 ->
        count_prime_factor(N div P, P, Count + 1);
    true ->
        {Count, N} % Return count and remaining N
    end.