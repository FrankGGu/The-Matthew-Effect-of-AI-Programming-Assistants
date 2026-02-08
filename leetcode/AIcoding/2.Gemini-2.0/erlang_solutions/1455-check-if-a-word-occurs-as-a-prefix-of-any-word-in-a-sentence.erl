-module(prefix_sentence).
-export([is_prefix_of_word/2]).

is_prefix_of_word(Sentence, SearchWord) ->
  Words = string:split(Sentence, " ", all),
  lists:any(fun(Word) -> string:starts_with(Word, SearchWord) end, Words).