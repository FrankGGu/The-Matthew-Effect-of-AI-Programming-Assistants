-module(solution).
-export([find_words/2]).

find_words(Words, Char) ->
    lists:filter(fun(Word) -> lists:member(Char, list_to_string(Word)) end, Words).