-module(solution).
-export([min_sideway_jumps/1]).

-define(INF, 1_000_000_000). % A sufficiently large number for infinity

min_sideway_jumps(Obstacles) ->
    N = length(Obstacles),
    % DP state: [MinJumpsLane1, MinJumpsLane2, MinJumpsLane3]
    % Initial state at point 0: Start in lane 2 (index 1), 0 jumps.
    % Other lanes are unreachable initially.
    InitialDP = [?INF, 0, ?INF],

    % Use a recursive helper to iterate through points
    ResultDP = solve(1, N, Obstacles, InitialDP),

    % The minimum jumps to reach the end point in any lane
    lists:min(ResultDP).

solve(Point, N, Obstacles, DP) when Point < N ->
    % Obstacles list is 1-indexed for lists:nth, but problem is 0-indexed for points.
    % So, Obstacles[Point] corresponds to lists:nth(Point + 1, Obstacles).
    ObstacleAtPoint = lists:nth(Point + 1, Obstacles),

    [D1, D2, D3] = DP,

    % Step 1: Calculate DP values for current point by moving forward from previous point
    % If a lane has an obstacle, it's unreachable (INF).
    ND1 = if ObstacleAtPoint == 1 -> ?INF; true -> D1 end,
    ND2 = if ObstacleAtPoint == 2 -> ?INF; true -> D2 end,
    ND3 = if ObstacleAtPoint == 3 -> ?INF; true -> D3 end,

    % Step 2: Account for sideways jumps at the current point.
    % A jump costs 1. We can jump from any lane to any other lane (if target is not blocked).
    % This is like a shortest path on 3 nodes (lanes) with edge weights 1.
    % Since there are only 3 lanes, two passes are sufficient to propagate all possible jumps.

    % Pass 1 for jumps:
    TempND1_P1 = ND1, TempND2_P1 = ND2, TempND3_P1 = ND3,

    ND1_AfterJump1 = if ObstacleAtPoint == 1 -> ?INF; true -> min3(TempND1_P1, TempND2_P1 + 1, TempND3_P1 + 1) end,
    ND2_AfterJump1 = if ObstacleAtPoint == 2 -> ?INF; true -> min3(TempND2_P1, TempND1_P1 + 1, TempND3_P1 + 1) end,
    ND3_AfterJump1 = if ObstacleAtPoint == 3 -> ?INF; true -> min3(TempND3_P1, TempND1_P1 + 1, TempND2_P1 + 1) end,

    % Pass 2 for jumps (ensures jumps like L1 -> L2 -> L3 are considered):
    TempND1_P2 = ND1_AfterJump1, TempND2_P2 = ND2_AfterJump1, TempND3_P2 = ND3_AfterJump1,

    FinalND1 = if ObstacleAtPoint == 1 -> ?INF; true -> min3(TempND1_P2, TempND2_P2 + 1, TempND3_P2 + 1) end,
    FinalND2 = if ObstacleAtPoint == 2 -> ?INF; true -> min3(TempND2_P2, TempND1_P2 + 1, TempND3_P2 + 1) end,
    FinalND3 = if ObstacleAtPoint == 3 -> ?INF; true -> min3(TempND3_P2, TempND1_P2 + 1, TempND2_P2 + 1) end,

    % Recurse for the next point with the updated DP values
    solve(Point + 1, N, Obstacles, [FinalND1, FinalND2, FinalND3]);

solve(N, N, _Obstacles, DP) ->
    % Base case: Reached the last point, return the final DP values.
    DP.

min3(A, B, C) ->
    min(A, min(B, C)).