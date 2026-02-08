-module(solution).
-export([halves_are_alike/1]).

halves_are_alike(S) ->
    Length = string:length(S) div 2,
    FirstHalf = string:substr(S, 1, Length),
    SecondHalf = string:substr(S, Length + 1, Length),
    CountVowels(FirstHalf) =:= CountVowels(SecondHalf).

CountVowels(Str) ->
    lists:foldl(fun(Char, Acc) ->
        if
            Char == $a orelse Char == $e orelse Char == $i orelse
            Char == $o orelse Char == $u orelse
            Char == $A orelse Char == $E orelse Char == $I orelse
            Char == $O orelse Char == $U -> Acc + 1;
            true -> Acc
        end
    end, 0, string:to_list(Str)).