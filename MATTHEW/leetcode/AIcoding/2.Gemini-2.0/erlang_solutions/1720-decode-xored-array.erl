-module(decode_xored_array).
-export([decode/2]).

decode(Encoded, First) ->
  decode(Encoded, First, [First]).

decode([], _, Acc) ->
  lists:reverse(Acc);
decode([H|T], Prev, Acc) ->
  Next = H bxor Prev,
  decode(T, Next, [Next|Acc]).