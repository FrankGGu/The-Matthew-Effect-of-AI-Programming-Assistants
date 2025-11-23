-module(solution).
-export([concatenated_binary/1]).

concatenated_binary(N) ->
    concatenated_binary(N, 0, 1, 1).

concatenated_binary(1, Acc, _Len, _Mod) ->
    Acc rem 1000000007;
concatenated_binary(N, Acc, Len, Mod) when N > 1 ->
    NewMod = Mod * 2,
    NewLen = if 
        NewMod > N -> Len;
        true -> Len + 1
    end,
    NewAcc = (Acc * (1 bsl NewLen) + N) rem 1000000007,
    concatenated_binary(N - 1, NewAcc, NewLen, NewMod).