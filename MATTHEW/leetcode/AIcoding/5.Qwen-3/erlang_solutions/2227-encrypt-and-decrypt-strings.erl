-module(encrypt_decrypt_strings).
-export([encode/2, decode/1]).

encode(Ids, Keys) ->
    encode(Ids, Keys, []).

encode([], _, Acc) ->
    lists:reverse(Acc);
encode([Id | RestIds], [Key | RestKeys], Acc) ->
    Encoded = encode_id(Id, Key),
    encode(RestIds, RestKeys, [Encoded | Acc]).

encode_id(Id, Key) ->
    encode_id(Id, Key, []).

encode_id([], _, Acc) ->
    lists:reverse(Acc);
encode_id([Char | Rest], [KChar | RestKey], Acc) ->
    EncodedChar = (Char + KChar) rem 256,
    encode_id(Rest, RestKey, [EncodedChar | Acc]).

decode(Encrypted) ->
    decode(Encrypted, []).

decode([], Acc) ->
    lists:reverse(Acc);
decode([Encoded | Rest], Acc) ->
    Decoded = decode_id(Encoded),
    decode(Rest, [Decoded | Acc]).

decode_id(Encoded) ->
    decode_id(Encoded, []).

decode_id([], Acc) ->
    lists:reverse(Acc);
decode_id([Char | Rest], Acc) ->
    DecodedChar = (Char - 128) rem 256,
    decode_id(Rest, [DecodedChar | Acc]).