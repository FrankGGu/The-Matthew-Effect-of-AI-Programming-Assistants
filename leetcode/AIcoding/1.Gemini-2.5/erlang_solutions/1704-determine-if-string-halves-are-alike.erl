-module(solution).
-export([halvesAreAlike/1]).

is_vowel(C) when C == $a$; C == $e$; C == $i$; C == $o$; C == $u$;
                 C == $A$; C == $E$; C == $I$; C == $O$; C == $U$ ->
    true;
is_vowel(_) ->
    false.

count_vowels(Str) ->
    lists:foldl(fun(Char, Acc) ->
                    if is_vowel(Char) -> Acc + 1;
                       true -> Acc
                    end
                end, 0, Str).

halvesAreAlike(S) ->
    Len = length(S),
    Mid = Len div 2,
    {Half1, Half2} = lists:split(Mid, S),
    Count1 = count_vowels(Half1),
    Count2 = count_vowels(Half2),
    Count1 == Count2.