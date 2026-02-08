-module(encrypted_string).
-export([encrypt_string/2]).

encrypt_string(S, K) ->
    encrypt_string(S, K, []).

encrypt_string([], _, Acc) ->
    lists:reverse(Acc);
encrypt_string([H | T], K, Acc) ->
    EncryptedChar = encrypt_char(H, K),
    encrypt_string(T, K, [EncryptedChar | Acc]).

encrypt_char(Char, K) ->
    Base = $a,
    Offset = Char - Base,
    (Offset + K) rem 26 + Base.