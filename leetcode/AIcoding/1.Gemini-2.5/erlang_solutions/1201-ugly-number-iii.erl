-module(solution).
-export([nthUglyNumber/4]).

nthUglyNumber(N, A, B, C) ->
    Low = 1,
    High = 2 * 1000000000 * 1000000000,
    binary_search(Low, High, N, A, B, C, High).

binary_search(Low, High, N, A, B, C, Ans) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    NumCount = count(Mid, A, B, C),
    if
        NumCount >= N ->
            binary_search(Low, Mid - 1, N, A, B, C, Mid);
        true ->
            binary_search(Mid + 1, High, N, A, B, C, Ans)
    end;
binary_search(_, _, _, _, _, _, Ans) ->
    Ans.

count(X, A, B, C) ->
    LcmAB = lcm(A, B),
    LcmAC = lcm(A, C),
    LcmBC = lcm(B, C),
    LcmABC = lcm(LcmAB, C),

    X div A + X div B + X div C
    - X div LcmAB
    - X div LcmAC
    - X div LcmBC
    + X div LcmABC.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> (A * B) div gcd(A, B).