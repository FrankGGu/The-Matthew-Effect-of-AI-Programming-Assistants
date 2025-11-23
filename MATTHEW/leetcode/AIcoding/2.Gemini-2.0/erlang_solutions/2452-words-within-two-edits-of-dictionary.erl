-module(words_within_two_edits).
-export([string_distance/2, solve/2]).

string_distance(S1, S2) ->
  string_distance(S1, S2, 0).

string_distance("", "", Acc) -> Acc;
string_distance("", _, Acc) -> Acc + length(_);
string_distance(_, "", Acc) -> Acc + length(_);
string_distance([H1 | T1], [H2 | T2], Acc) ->
  case H1 =:= H2 of
    true -> string_distance(T1, T2, Acc);
    false -> string_distance(T1, T2, Acc + 1)
  end.

solve(Words, Dictionary) ->
  solve(Words, Dictionary, []).

solve([], _, Acc) -> lists:reverse(Acc);
solve([Word | Rest], Dictionary, Acc) ->
  case lists:any(fun(DictWord) -> string_distance(Word, DictWord) =< 2 end, Dictionary) of
    true -> solve(Rest, Dictionary, [Word | Acc]);
    false -> solve(Rest, Dictionary, Acc)
  end.

words_within_two_edits(Words, Dictionary) ->
  solve(Words, Dictionary).