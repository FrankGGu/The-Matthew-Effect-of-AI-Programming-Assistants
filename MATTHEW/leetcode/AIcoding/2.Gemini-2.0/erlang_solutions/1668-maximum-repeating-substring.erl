-module(maximum_repeating_substring).
-export([max_repeating/2]).

max_repeating(Sequence, Word) ->
  max_repeating(Sequence, Word, 0).

max_repeating(Sequence, Word, Count) ->
  case string:str(Sequence, string:copies(Word, Count + 1)) of
    nomatch ->
      Count;
    _ ->
      max_repeating(Sequence, Word, Count + 1)
  end.