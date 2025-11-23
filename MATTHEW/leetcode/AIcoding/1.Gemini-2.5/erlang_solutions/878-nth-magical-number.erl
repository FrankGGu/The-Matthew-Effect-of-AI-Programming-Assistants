-module(solution).
-export([nthMagicalNumber/3]).

-define(MOD, 1000000007).

nthMagicalNumber(N, A, B) ->
    LCM_AB = lcm(A, B),
    Low = 1,
    High = N * max(A, B),
    Result = binary_search_loop(Low, High, High, N, A, B, LCM_AB),
    Result rem ?MOD.

binary_search_loop(Low, High, Ans, N, A, B, LCM_AB) ->
    if
        Low =< High ->
            Mid = Low + (High - Low) div 2,
            Count = count_magical(Mid, A, B, LCM_AB),
            if
                Count >= N ->
                    binary_search_loop(Low, Mid - 1, Mid, N, A, B, LCM_AB);
                true ->
                    binary_search_loop(Mid + 1, High, Ans, N, A, B, LCM_AB)
            end;
        true ->
            Ans
    end.

count_magical(X, A, B, LCM_AB) ->
    (X div A) + (X div B) - (X div LCM_AB).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> (A * B) div gcd(A, B).