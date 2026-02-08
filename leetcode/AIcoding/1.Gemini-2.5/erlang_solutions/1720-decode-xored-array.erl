-module(solution).
-export([decode/2]).

decode(Encoded, First) ->
    decode_acc(Encoded, First, [First]).

decode_acc([], _Prev, Acc) ->
    lists:reverse(Acc);
decode_acc([H|T], Prev, Acc) ->
    Next = H bxor Prev,
    decode_acc(T, Next, [Next|Acc]).