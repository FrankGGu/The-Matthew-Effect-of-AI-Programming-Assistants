-module(solution).
-export([gridGame/1]).

-spec gridGame(Grid :: [[integer()]]) -> integer().
gridGame(Grid) ->
    [Row0, Row1] = Grid,
    InitialSumRow0 = lists:sum(Row0),
    solve(Row0, Row1, InitialSumRow0, 0, 10000000000).

solve([], [], _CurrentSumRow0Right, _CurrentSumRow1Left, MinRobot2Score) ->
    MinRobot2Score;
solve([H0|T0], [H1|T1], CurrentSumRow0Right, CurrentSumRow1Left, MinRobot2Score) ->
    NewCurrentSumRow0Right = CurrentSumRow0Right - H0,
    Robot2Score = max(NewCurrentSumRow0Right, CurrentSumRow1Left),
    NewMinRobot2Score = min(MinRobot2Score, Robot2Score),
    NewCurrentSumRow1Left = CurrentSumRow1Left + H1,
    solve(T0, T1, NewCurrentSumRow0Right, NewCurrentSumRow1Left, NewMinRobot2Score).

max(A, B) when A >= B -> A;
max(A, B) -> B.

min(A, B) when A =< B -> A;
min(A, B) -> B.