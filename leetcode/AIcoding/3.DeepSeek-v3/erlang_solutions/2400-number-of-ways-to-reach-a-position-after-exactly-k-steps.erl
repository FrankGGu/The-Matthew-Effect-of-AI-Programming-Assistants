-module(solution).
-export([number_of_ways/3]).

number_of_ways(StartPos, EndPos, K) ->
    Mod = 1000000007,
    Diff = abs(EndPos - StartPos),
    if
        (K < Diff) or ((K - Diff) rem 2 =/= 0) -> 0;
        true -> 
            comb(K, (K + Diff) div 2, Mod)
    end.

comb(N, K, Mod) ->
    if
        K > N -> 0;
        true ->
            K1 = min(K, N - K),
            comb(N, K1, 1, 1, Mod)
    end.

comb(_, 0, Res, _, _) -> Res;
comb(N, K, Res, Denom, Mod) ->
    NewRes = (Res * (N - K + 1)) rem Mod,
    NewDenom = (Denom * K) rem Mod,
    comb(N, K - 1, NewRes, NewDenom, Mod).