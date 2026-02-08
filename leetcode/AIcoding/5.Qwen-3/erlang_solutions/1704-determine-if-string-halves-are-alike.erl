-module(solution).
-export([halves_are_alike/1]).

halves_are_alike(S) ->
    A = string:substr(S, 1, length(S) div 2),
    B = string:substr(S, length(S) div 2 + 1),
    CountA = count_vowels(A),
    CountB = count_vowels(B),
    CountA == CountB.

count_vowels(Str) ->
    lists:foldl(fun(Char, Acc) ->
        case lists:member(Char, [$a,$e,$i,$o,$u,$A,$E,$I,$O,$U]) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Str).