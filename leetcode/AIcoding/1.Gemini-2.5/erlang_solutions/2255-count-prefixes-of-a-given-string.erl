-module(solution).
-export([count_prefixes/2]).

count_prefixes(Words, S) ->
    lists:sum([1 || Word <- Words, string:prefix(Word, S)]).