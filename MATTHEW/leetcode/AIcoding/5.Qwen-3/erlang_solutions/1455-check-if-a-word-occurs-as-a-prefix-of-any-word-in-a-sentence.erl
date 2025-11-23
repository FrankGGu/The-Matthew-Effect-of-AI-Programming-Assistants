-module(solution).
-export([is_prefix/2]).

is_prefix(Sentence, Word) ->
    Words = string:split(Sentence, " "),
    lists:any(fun(W) -> string:prefix(Word, W) end, Words).