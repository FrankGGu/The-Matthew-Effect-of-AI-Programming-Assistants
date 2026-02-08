-module(decode_string).
-export([decode_string/1]).

decode_string(S) ->
  {Result, _} = decode(S, []),
  list_to_binary(lists:reverse(Result)).

decode(S, Acc) ->
  decode(binary_to_list(S), Acc).

decode([], Acc) ->
  {Acc, []};
decode([C | Rest], Acc) when C >= $0, C =< $9 ->
  {Num, NewRest} = read_number([C | Rest], []),
  decode(NewRest, Acc, list_to_integer(lists:reverse(Num)));
decode([$[ | Rest], Acc) ->
  {Decoded, NewRest} = decode(Rest, []),
  decode(NewRest, lists:append(Acc, Decoded));
decode([$] | Rest], Acc) ->
  {Acc, Rest};
decode([Char | Rest], Acc) ->
  decode(Rest, [Char | Acc]).

decode(Rest, Acc, 0) ->
  {Acc, Rest};
decode(Rest, Acc, N) ->
  {Decoded, _} = decode(Rest, []),
  NewAcc = lists:append(Acc, Decoded),
  decode(Rest, NewAcc, N - 1).

read_number(Chars, Acc) ->
  read_number(Chars, Acc, []).

read_number([], Acc, Result) ->
  {lists:reverse(Acc), []};
read_number([C | Rest], Acc, Result) when C >= $0, C =< $9 ->
  read_number(Rest, [C | Acc], Result);
read_number(Rest, Acc, Result) ->
  {lists:reverse(Acc), Rest}.