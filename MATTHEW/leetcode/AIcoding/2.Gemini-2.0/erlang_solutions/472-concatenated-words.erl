-module(concatenated_words).
-export([find_all_concatenated_words/1]).

find_all_concatenated_words(Words) ->
  Set = sets:from_list(Words),
  lists:filter(fun(Word) -> is_concatenated(Word, Set) end, Words).

is_concatenated(Word, Set) ->
  is_concatenated(Word, Set, 0, maps:new()).

is_concatenated("", _, _, _) ->
  true;
is_concatenated(Word, Set, Start, Memo) ->
  case maps:get(Word, Memo, undefined) of
    true ->
      true;
    _ ->
      Len = length(Word),
      lists:any(fun(I) ->
                  Prefix = string:sub(Word, 1, I),
                  (sets:is_element(Prefix, Set) and (length(Prefix) < Len)) andalso
                    is_concatenated(string:sub(Word, I + 1, Len - I), Set, Start + I, Memo)
                end, lists:seq(1, Len - 1))
  end.