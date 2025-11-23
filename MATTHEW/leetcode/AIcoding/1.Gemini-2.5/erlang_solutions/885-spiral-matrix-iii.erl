-module(solution).
-export([spiralMatrixIII/4]).

spiralMatrixIII(Rows, Cols, RStart, CStart) ->
    Dr = [0, 1, 0, -1], % Right, Down, Left, Up
    Dc = [1, 0, -1, 0], % Right, Down, Left, Up

    MaxTotal = Rows * Cols,

    % Initial state:
    % Current R, C
    % Current direction index (0:R, 1:D, 2:L, 3:U)
    % Current step length for the segment
    % Counter for how many segments we've moved with the current step length (0 or 1)
    % Total visited cells
    % Accumulator for results (reversed list)
    % MaxTotal (Rows * Cols) for early termination

    % The first point (RStart, CStart) is always visited.
    helper(Rows, Cols, Dr, Dc, RStart, CStart, 0, 1, 0, 1, [[RStart, CStart]], MaxTotal).

helper(_Rows, _Cols, _Dr, _Dc, _R, _C, _DirIdx, _StepLen, _CurrentStepLenCount, TotalVisited, AccResult, MaxTotal)
  when TotalVisited == MaxTotal ->
    lists:reverse(AccResult);
helper(Rows, Cols, Dr, Dc, R, C, DirIdx, StepLen, CurrentStepLenCount, TotalVisited, AccResult, MaxTotal) ->
    % Get current direction vectors
    CurDr = lists:nth(DirIdx + 1, Dr),
    CurDc = lists:nth(DirIdx + 1, Dc),

    % Move StepLen times in the current direction
    % This function returns the final R, C after moving StepsToMove,
    % the updated TotalVisited count, and the updated AccResult.
    {NewR, NewC, NewTotalVisited, NewAccResult} = 
        move_segment(Rows, Cols, CurDr, CurDc, StepLen, R, C, TotalVisited, AccResult, MaxTotal),

    % Update direction and step length for the next segment
    NextDirIdx = (DirIdx + 1) rem 4,
    NextCurrentStepLenCount = CurrentStepLenCount + 1,

    {NextStepLen, FinalCurrentStepLenCount} =
        if NextCurrentStepLenCount == 2 -> 
            {StepLen + 1, 0};
        true -> 
            {StepLen, NextCurrentStepLenCount}
        end,

    helper(Rows, Cols, Dr, Dc, NewR, NewC, NextDirIdx, NextStepLen, FinalCurrentStepLenCount, NewTotalVisited, NewAccResult, MaxTotal).

move_segment(_Rows, _Cols, _CurDr, _CurDc, _StepsToMove, CurrentR, CurrentC, TotalVisited, AccResult, MaxTotal)
  when TotalVisited == MaxTotal ->
    {CurrentR, CurrentC, TotalVisited, AccResult};
move_segment(_Rows, _Cols, _CurDr, _CurDc, 0, CurrentR, CurrentC, TotalVisited, AccResult, _MaxTotal) ->
    {CurrentR, CurrentC, TotalVisited, AccResult};
move_segment(Rows, Cols, CurDr, CurDc, StepsToMove, R, C, TotalVisited, AccResult, MaxTotal) ->
    NextR = R + CurDr,
    NextC = C + CurDc,

    {NewTotalVisited, NewAccResult} =
        if NextR >= 0 andalso NextR < Rows andalso NextC >= 0 andalso NextC < Cols ->
            {TotalVisited + 1, [[NextR, NextC] | AccResult]};
        true ->
            {TotalVisited, AccResult}
        end,

    move_segment(Rows, Cols, CurDr, CurDc, StepsToMove - 1, NextR, NextC, NewTotalVisited, NewAccResult, MaxTotal).