-module(maximum_words).
-export([canBeTypedWords/2]).

canBeTypedWords(Text, BrokenLetters) ->
  Words = string:split(Text, " ", all),
  lists:foldl(
    fun(Word, Acc) ->
      case string:find(Word, BrokenLetters, case_insensitive) of
        nomatch -> Acc + 1;
        _ -> Acc
      end
    end,
    0,
    Words
  ).