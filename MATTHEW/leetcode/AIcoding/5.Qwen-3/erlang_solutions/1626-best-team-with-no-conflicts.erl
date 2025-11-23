-module(best_team_with_no_conflicts).
-export([best_team/1]).

best_team(Players) ->
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A =< B end, Players),
    N = length(Sorted),
    DP = array:new(N, {default, 0}),
    Max = 0,
    best_team(Sorted, 0, N, DP, Max).

best_team(_, _, N, _, Max) when N == 0 ->
    Max;
best_team(Sorted, I, N, DP, Max) ->
    {Age, Score} = lists:nth(I + 1, Sorted),
    CurrentMax = best_team_helper(Sorted, I, N, DP, 0),
    NewMax = max(Max, CurrentMax),
    best_team(Sorted, I + 1, N, DP, NewMax).

best_team_helper(_, _, N, _, Acc) when N == 0 ->
    Acc;
best_team_helper(Sorted, I, N, DP, Acc) ->
    {Age, Score} = lists:nth(I + 1, Sorted),
    Best = case array:get(I, DP) of
               0 ->
                   BestScore = Score,
                   BestScore;
               Val ->
                   Val
           end,
    NextAcc = max(Acc, Best),
    best_team_helper(Sorted, I, N - 1, DP, NextAcc).

best_team_helper(_, _, 0, _, Acc) ->
    Acc;
best_team_helper(Sorted, I, J, DP, Acc) ->
    {AgeJ, ScoreJ} = lists:nth(J + 1, Sorted),
    if
        AgeJ >= lists:nth(I + 1, Sorted) ->
            {AgeI, ScoreI} = lists:nth(I + 1, Sorted),
            Current = ScoreI + array:get(J, DP),
            NewVal = max(array:get(I, DP), Current),
            array:set(I, NewVal, DP),
            best_team_helper(Sorted, I, J - 1, DP, Acc);
        true ->
            best_team_helper(Sorted, I, J - 1, DP, Acc)
    end.