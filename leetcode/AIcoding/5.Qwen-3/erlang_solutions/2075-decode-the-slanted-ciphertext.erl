-module(decode_the_slanted_ciphertext).
-export([decodeCiphertext/2]).

decodeCiphertext(EncryptedString, k) ->
    N = length(EncryptedString),
    Rows = lists:seq(0, k-1),
    Result = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Col, Acc2) ->
            Index = Row + Col * k,
            if
                Index < N -> [lists:nth(Index+1, EncryptedString) | Acc2];
                true -> Acc2
            end
        end, Acc, lists:seq(0, (N - Row - 1) div k))
    end, [], Rows),
    lists:reverse(Result).