-module(first_letter_capitalization_ii).
-export([solve/1]).

solve(S) ->
  Words = string:tokens(S, " "),
  CapitalizedWords = [capitalize_word(Word) || Word <- Words],
  string:join(CapitalizedWords, " ").

capitalize_word(Word) ->
  case string:length(Word) of
    0 -> "";
    _ ->
      [string:to_upper(string:sub(Word, 1, 1))] ++ string:sub(Word, 2)
  end.