-module(solution).
-export([encrypt/1]).

encrypt(N) ->
    encrypt(N, 0).

encrypt(0, Acc) ->
    Acc;
encrypt(N, Acc) ->
    Digit = N rem 10,
    EncryptedDigit = case Digit of
        0 -> 0;
        1 -> 1;
        2 -> 5;
        3 -> 7;
        4 -> 9;
        5 -> 2;
        6 -> 8;
        7 -> 3;
        8 -> 6;
        9 -> 4
    end,
    encrypt(N div 10, Acc * 10 + EncryptedDigit).