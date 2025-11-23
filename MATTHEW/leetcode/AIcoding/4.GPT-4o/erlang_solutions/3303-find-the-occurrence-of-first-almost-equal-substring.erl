-module(solution).
-export([find_occurrence/2]).

find_occurrence(Str1, Str2) ->
    case almost_equal_substring(Str1, Str2) of
        {ok, Index} -> Index;
        {error, _} -> -1
    end.

almost_equal_substring(Str1, Str2) ->
    {Len1, Len2} = {string:length(Str1), string:length(Str2)},
    lists:mapfoldl(fun(I, Acc) ->
        case substring_equal(Str1, Str2, I, Len2) of
            true -> {halt, I};
            false -> {cont, Acc + 1}
        end
    end, 0, lists:seq(0, Len1 - Len2)).

substring_equal(Str1, Str2, Start, Len) ->
    Substr = string:substr(Str1, Start + 1, Len),
    Substr =:= Str2.