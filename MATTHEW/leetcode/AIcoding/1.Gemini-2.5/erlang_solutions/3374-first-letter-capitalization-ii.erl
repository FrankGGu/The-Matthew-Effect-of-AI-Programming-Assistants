-module(solution).
-export([firstLetterCapitalization/1]).

firstLetterCapitalization(S) ->
    capitalize_words(S, true).

capitalize_words([], _CapitalizeNext) -> [];
capitalize_words([H|T], CapitalizeNext) when H == $\s ->
    [H | capitalize_words(T, true)];
capitalize_words([H|T], true) when H >= $a, H <= $z ->
    [H - 32 | capitalize_words(T, false)];
capitalize_words([H|T], true) when H >= $A, H <= $Z ->
    [H | capitalize_words(T, false)];
capitalize_words([H|T], false) when H >= $a, H <= $z ->
    [H | capitalize_words(T, false)];
capitalize_words([H|T], false) when H >= $A, H <= $Z ->
    [H | capitalize_words(T, false)];
capitalize_words([H|T], _CapitalizeNext) ->
    [H | capitalize_words(T, true)].