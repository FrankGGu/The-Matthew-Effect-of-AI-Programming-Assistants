-module(solution).
-export([split_strings_by_separator/2]).

split_strings_by_separator(Words, Separator) ->
    lists:flatmap(fun(Word) ->
                      string:tokens(Word, [Separator])
                  end, Words).