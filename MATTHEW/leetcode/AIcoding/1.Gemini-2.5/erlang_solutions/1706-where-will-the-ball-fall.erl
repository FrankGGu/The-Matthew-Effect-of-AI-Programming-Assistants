-module(solution).
-export([findBall/1]).

findBall(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    simulate_ball(CurrentRow, CurrentCol) ->
        if CurrentRow == M ->
            CurrentCol;
           true ->
            ThisRowList = lists:nth(CurrentRow + 1, Grid),
            PlankType = lists:nth(CurrentCol + 1, ThisRowList),

            if PlankType == 1 ->
                NextCol = CurrentCol + 1,
                if NextCol >= N ->
                    -1;
                   lists:nth(NextCol + 1, ThisRowList) == -1 ->
                    -1;
                   true ->
                    simulate_ball(CurrentRow + 1, NextCol)
                end;
               PlankType == -1 ->
                NextCol = CurrentCol - 1,
                if NextCol < 0 ->
                    -1;
                   lists:nth(NextCol + 1, ThisRowList) == 1 ->
                    -1;
                   true ->
                    simulate_ball(CurrentRow + 1, NextCol)
                end
            end
        end.

    [simulate_ball(0, StartCol) || StartCol <- lists:seq(0, N - 1)].