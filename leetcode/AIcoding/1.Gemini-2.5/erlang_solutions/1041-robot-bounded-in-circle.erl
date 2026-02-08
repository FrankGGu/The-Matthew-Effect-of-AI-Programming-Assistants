-module(solution).
-export([isRobotBounded/1]).

isRobotBounded(Instructions) ->
    InitialState = {0, 0, 0}, % {X, Y, Direction} (0:N, 1:E, 2:S, 3:W)
    {FinalX, FinalY, FinalDir} = lists:foldl(fun process_instruction/2, InitialState, Instructions),
    (FinalX == 0 andalso FinalY == 0) orelse (FinalDir /= 0).

process_instruction($G, {X, Y, Dir}) ->
    case Dir of
        0 -> {X, Y + 1, Dir}; % North
        1 -> {X + 1, Y, Dir}; % East
        2 -> {X, Y - 1, Dir}; % South
        3 -> {X - 1, Y, Dir}  % West
    end;
process_instruction($L, {X, Y, Dir}) ->
    {X, Y, (Dir - 1 + 4) rem 4}; % Turn Left
process_instruction($R, {X, Y, Dir}) ->
    {X, Y, (Dir + 1) rem 4}.  % Turn Right