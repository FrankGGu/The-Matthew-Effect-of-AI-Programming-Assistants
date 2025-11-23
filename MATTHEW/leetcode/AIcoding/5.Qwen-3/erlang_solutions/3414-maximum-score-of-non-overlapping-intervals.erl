-module(maximum_score_of_non_overlapping_intervals).
-export([solve/1]).

solve(Intervals) ->
    Sorted = lists:sort(fun({A, B}, {C, D}) -> A =< C end, Intervals),
    solve(Sorted, 0, 0).

solve([], _, Score) ->
    Score;
solve([{Start, End} | Rest], LastEnd, Score) ->
    if
        Start >= LastEnd ->
            solve(Rest, End, Score + 1);
        true ->
            solve(Rest, LastEnd, Score)
    end.