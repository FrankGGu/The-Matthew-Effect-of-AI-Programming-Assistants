-module(solution).
-export([freq_alphabets/1]).

freq_alphabets(Str) ->
    decrypt(Str, []).

decrypt([], Acc) ->
    lists:reverse(Acc);
decrypt([C1, C2 | Rest], Acc) when C1 >= $1 andalso C1 =< $9 andalso C2 >= $0 andalso C2 =< $9 ->
    Num = (C1 - $0) * 10 + (C2 - $0),
    Char = char(Num),
    decrypt(Rest, [Char | Acc]);
decrypt([C | Rest], Acc) ->
    Num = C - $0,
    Char = char(Num),
    decrypt(Rest, [Char | Acc]).

char(N) ->
    N + $a - 1.