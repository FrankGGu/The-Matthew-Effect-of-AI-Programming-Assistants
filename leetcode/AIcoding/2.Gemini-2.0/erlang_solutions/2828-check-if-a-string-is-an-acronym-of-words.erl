-module(acronym).
-export([is_acronym/2]).

is_acronym(Words, S) ->
  is_acronym(Words, S, 0).

is_acronym([], "", _) ->
  true;
is_acronym([Word | Rest], S, Index) ->
  case string:starts_with(S, string:substr(Word, 1, 1), Index + 1) of
    true ->
      is_acronym(Rest, S, Index + string:length(Word));
    false ->
      false
  end;
is_acronym(_, _, _) ->
  false.