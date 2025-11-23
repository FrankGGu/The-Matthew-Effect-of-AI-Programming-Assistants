-module(solution).
-export([array_strings_are_equal/2]).

array_strings_are_equal(Word1, Word2) ->
    lists:flatten(Word1) == lists:flatten(Word2).