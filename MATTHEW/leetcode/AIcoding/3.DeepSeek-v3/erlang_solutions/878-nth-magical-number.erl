-module(solution).
-export([nth_magical_number/3]).

nth_magical_number(N, A, B) ->
    Mod = 1000000007,
    L = lcm(A, B),
    Low = 1,
    High = 1 bsl 60,
    binary_search(N, A, B, L, Low, High, Mod).

binary_search(N, A, B, L, Low, High, Mod) ->
    if
        Low >= High -> Low rem Mod;
        true ->
            Mid = (Low + High) div 2,
            Count = (Mid div A) + (Mid div B) - (Mid div L),
            if
                Count < N -> binary_search(N, A, B, L, Mid + 1, High, Mod);
                true -> binary_search(N, A, B, L, Low, Mid, Mod)
            end
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> (A * B) div gcd(A, B).