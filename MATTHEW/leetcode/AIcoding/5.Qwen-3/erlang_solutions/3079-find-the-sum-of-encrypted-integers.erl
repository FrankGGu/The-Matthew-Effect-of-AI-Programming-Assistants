-module(solution).
-export([sum_encrypted_numbers/1]).

sum_encrypted_numbers(Numbers) ->
    lists:sum([encrypt(N) || N <- Numbers]).

encrypt(N) ->
    encrypt(N, 0, 0).

encrypt(0, _Digits, Encrypted) ->
    Encrypted;
encrypt(N, Digits, Encrypted) ->
    Digit = N rem 10,
    encrypt(N div 10, Digits + 1, Encrypted * 10 + Digit).