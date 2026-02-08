-module(solution).
-export([minSteps/2]).

minSteps(S, T) ->
    FreqS = count_chars(S, lists:duplicate(26, 0)),
    FreqT = count_chars(T, lists:duplicate(26, 0)),
    calculate_steps(FreqS, FreqT, 0).

count_chars([], Freq) ->
    Freq;
count_chars([H|Rest], Freq) ->
    Index = H - $a,
    CurrentCount = lists:nth(Index + 1, Freq),
    NewFreq = lists:replace_at(Index + 1, CurrentCount + 1, Freq),
    count_chars(Rest, NewFreq).

calculate_steps([], [], Acc) ->
    Acc;
calculate_steps([FS|FSRest], [FT|FTRest], Acc) ->
    Steps = max(0, FT - FS),
    calculate_steps(FSRest, FTRest, Acc + Steps).

max(A, B) ->
    if A > B -> A;
       true -> B
    end.