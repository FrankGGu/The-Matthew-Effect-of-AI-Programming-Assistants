-module(decrypt_string).
-export([freq_alphabets/1]).

freq_alphabets(S) ->
  freq_alphabets(S, []).

freq_alphabets([], Acc) ->
  lists:reverse(Acc);
freq_alphabets([C|Rest], Acc) when C >= $1, C =< $9 ->
  Char = C - $1 + $a,
  freq_alphabets(Rest, [Char|Acc]);
freq_alphabets([C1, C2, $#|Rest], Acc) when C1 >= $1, C1 =< $2, C2 >= $0, C2 =< $9 ->
  Num = (C1 - $0) * 10 + (C2 - $0),
  Char = Num - 1 + $a,
  freq_alphabets(Rest, [Char|Acc]);
freq_alphabets(_, _)-> "".