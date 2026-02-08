-module(solution).
-export([get_total_characters/2]).

get_total_characters(Str, K) ->
    Length = string:length(Str),
    TotalCharacters = Length * K,
    TotalCharacters.