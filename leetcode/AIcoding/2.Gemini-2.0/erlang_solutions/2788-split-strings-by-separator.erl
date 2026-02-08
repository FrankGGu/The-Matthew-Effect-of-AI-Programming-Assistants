-module(split_string).
-export([split_string/2]).

split_string(Words, Separator) ->
    lists:flatten([string:tokens(Word, [Separator]) || Word <- Words]).