-module(concatenation_binary).
-export([concatenated_binary/1]).

concatenated_binary(N) ->
    concatenated_binary(N, 0, 1, 0).

concatenated_binary(0, Acc, _, _) ->
    Acc;
concatenated_binary(N, Acc, Len, Shift) ->
    NewLen = case N band (1 bsl Shift) of
                 0 -> Len;
                 _ ->
                     case (Shift + 1) >= Len of
                         true -> Len + 1;
                         false -> Len
                     end
             end,
    NewAcc = (Acc * (1 bsl NewLen) + N) rem 1000000007,
    concatenated_binary(N - 1, NewAcc, NewLen, Shift + 1).