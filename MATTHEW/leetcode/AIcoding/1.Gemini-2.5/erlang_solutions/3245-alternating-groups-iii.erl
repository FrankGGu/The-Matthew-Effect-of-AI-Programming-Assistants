-module(solution).
-export([alternatingGroups/2]).

alternatingGroups(Colors, K) ->
    N = length(Colors),
    if
        N == 0 -> 0;
        K == 1 -> N;
        K > N -> 0;
        true ->
            ExtendedColors = Colors ++ lists:sublist(Colors, 1, K - 1),
            [H | T] = ExtendedColors,
            solve_sliding_window(T, H, K, 0, 0)
    end.

solve_sliding_window([NextColor | Rest], PrevColor, K, AlternatingStreak, Result) ->
    NewAlternatingStreak = if PrevColor =/= NextColor -> AlternatingStreak + 1; true -> 0 end,

    NewResult = if NewAlternatingStreak >= K - 1 -> Result + 1; true -> Result end,

    solve_sliding_window(Rest, NextColor, K, NewAlternatingStreak, NewResult);

solve_sliding_window([], _PrevColor, _K, _AlternatingStreak, Result) ->
    Result.