-module(solution).
-export([kthSmallestPrimeFraction/2]).

kthSmallestPrimeFraction(P, K) ->
    N = length(P),
    Fractions = [ {P1, P2} || {P1, P2} <- lists:seq(1, N) -- lists:seq(1, N), P1 < P2 ],
    Sorted = lists:sort(fun({X1, Y1}, {X2, Y2}) -> X1 * Y2 > X2 * Y1 end, Fractions),
    {A, B} = lists:nth(K, Sorted),
    {A, B}.