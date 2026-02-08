-module(find_words_containing_character).
-export([solve/2]).

solve(Words, Character) ->
  [Word || Word <- Words, string:str(Word, [Character]) > 0].