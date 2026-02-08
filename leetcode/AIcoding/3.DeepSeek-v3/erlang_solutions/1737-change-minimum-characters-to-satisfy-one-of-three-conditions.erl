-module(solution).
-export([min_characters/2]).

min_characters(A, B) ->
    FreqA = count_freq(A),
    FreqB = count_freq(B),
    Option1 = option1(FreqA, FreqB),
    Option2 = option2(FreqA, FreqB),
    Option3 = option3(FreqA, FreqB),
    lists:min([Option1, Option2, Option3]).

count_freq(S) ->
    Freq = lists:duplicate(26, 0),
    lists:foldl(fun(C, Acc) ->
                    Index = C - $a,
                    lists:sublist(Acc, 1, Index) ++ [lists:nth(Index + 1, Acc) + 1] ++ lists:sublist(Acc, Index + 2, 26 - Index - 1)
                end, Freq, S).

option1(FreqA, FreqB) ->
    lists:min([lists:sum(lists:sublist(FreqA, I + 1, 26 - I)) + lists:sum(lists:sublist(FreqB, 1, I)) || I <- lists:seq(1, 25)]).

option2(FreqA, FreqB) ->
    lists:min([lists:sum(lists:sublist(FreqB, I + 1, 26 - I)) + lists:sum(lists:sublist(FreqA, 1, I)) || I <- lists:seq(1, 25)]).

option3(FreqA, FreqB) ->
    LenA = lists:sum(FreqA),
    LenB = lists:sum(FreqB),
    lists:min([LenA + LenB - lists:nth(I + 1, FreqA) - lists:nth(I + 1, FreqB) || I <- lists:seq(0, 25)]).