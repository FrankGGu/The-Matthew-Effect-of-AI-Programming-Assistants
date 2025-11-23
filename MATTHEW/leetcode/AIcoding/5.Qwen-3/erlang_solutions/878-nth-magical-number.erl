-module(nth_magical_number).
-export([nthMagicalNumber/2]).

nthMagicalNumber(N, K) ->
    L = lcm(1, 2),
    LCM = find_lcm(lists:seq(1, K)),
    nthMagicalNumber(N, K, LCM).

nthMagicalNumber(N, K, LCM) ->
    Left = 1,
    Right = LCM * N,
    nthMagicalNumber(N, K, LCM, Left, Right).

nthMagicalNumber(N, K, LCM, Left, Right) ->
    Mid = (Left + Right) div 2,
    Count = count(Mid, K),
    if
        Count < N -> nthMagicalNumber(N, K, LCM, Mid + 1, Right);
        true -> nthMagicalNumber(N, K, LCM, Left, Mid - 1)
    end.

count(X, K) ->
    lists:sum([X div I || I <- lists:seq(1, K)]) - 
    lists:sum([X div LCM(I, J) || I <- lists:seq(1, K), J <- lists:seq(I + 1, K)]) +
    lists:sum([X div LCM(I, J, L) || I <- lists:seq(1, K), J <- lists:seq(I + 1, K), L <- lists:seq(J + 1, K)]) - ... .

lcm(A, B) ->
    A * B div gcd(A, B).

gcd(A, B) when B == 0 -> A;
gcd(A, B) -> gcd(B, A rem B).

find_lcm([]) -> 1;
find_lcm([H | T]) -> lcm(H, find_lcm(T)).