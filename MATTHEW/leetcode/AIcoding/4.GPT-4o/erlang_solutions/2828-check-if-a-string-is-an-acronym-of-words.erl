-module(solution).
-export([isAcronym/2]).

isAcronym(Words, Abbreviation) ->
    WordsList = string:tokens(Words, " "),
    Acronym = lists:map(fun Word -> string:substr(Word, 1, 1) end, WordsList),
    Acronym =:= string:to_upper(Abbreviation).