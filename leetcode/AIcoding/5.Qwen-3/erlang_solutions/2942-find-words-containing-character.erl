-module(solution).
-export([find_words/2]).

find_words(WordList, Ch) ->
    [Word || Word <- WordList, lists:member(Ch, Word)].