-module(solution).
-export([is_prefix/2]).

is_prefix(Prefix, Sentence) ->
    Words = string:tokens(Sentence, " "),
    lists:any(fun(Word) -> string:starts_with(Word, Prefix) end, Words).