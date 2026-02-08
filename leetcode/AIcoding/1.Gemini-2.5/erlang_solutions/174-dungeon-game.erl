-module(solution).
-export([calculateMinimumHP/1]).

calculateMinimumHP(Dungeon) ->
    M = length(Dungeon),
    N = length(hd(Dungeon)),
    Infinity = 1000000000, % A sufficiently large number

    % Initial DpRowBelow represents dp[M], the row conceptually below the dungeon.
    % For any cell (R, C), if we go down to (R+1, C), and R+1 == M,
    % then we are exiting the dungeon. The minimum health needed to "enter" (M, C)
    % is 1 if C == N-1 (the target column), otherwise Infinity.
    % However, the general DP formula handles this by considering paths to (M, C)
    % and (R, N).
    % A simpler way to handle boundaries is to imagine a border of cells (M, j) and (i, N)
    % that require 1 health to "pass through" if they are the destination, and Infinity otherwise.
    % The actual destination is (M-1, N-1).
    % So, dp[M][N-1] = 1, dp[M-1][N] = 1. All other dp[M][j] and dp[i][N] are Infinity.
    %
    % The `DpRowBelow` list represents `dp[R+1]` values.
    % `lists:duplicate(N - 1, Infinity) ++ [1]` initializes `dp[M]` such that `dp[M][N-1]` is 1, and others are Infinity.
    % This correctly models the 'down' path from `(M-1, N-1)` requiring 1 health.
    InitialDpRowBelow = lists:duplicate(N - 1, Infinity) ++ [1],

    % `lists:foldr` iterates rows from M-1 down to 0.
    % `DpRowBelow` for current iteration `R` is the `dp[R+1]` list.
    FinalDpRow = lists:foldr(
        fun(R, DpRowBelow) ->
            % `lists:foldr` iterates columns from N-1 down to 0.
            % `DpRightValsAcc` accumulates `[dp[R][C+1], dp[R][C+2], ..., dp[R][N-1], dp[R][N]]`.
            % `dp[R][N]` (right of dungeon) is initialized to 1.
            % This correctly models the 'right' path from `(M-1, N-1)` requiring 1 health.
            lists:foldr(
                fun(C, DpRightValsAcc) ->
                    Val = lists:nth(C + 1, lists:nth(R + 1, Dungeon)),

                    HealthFromRight = hd(DpRightValsAcc), % This is dp[R][C+1]
                    HealthFromDown = lists:nth(C + 1, DpRowBelow), % This is dp[R+1][C]

                    MinHealthRequiredFromNext = min(HealthFromRight, HealthFromDown),

                    HealthNeededBeforeCell = max(1, MinHealthRequiredFromNext - Val),

                    [HealthNeededBeforeCell | DpRightValsAcc]
                end,
                [1], % Initial DpRightValsAcc for the inner foldr (representing dp[R][N])
                lists:seq(N - 1, 0, -1) % Iterate columns from N-1 down to 0
            )
        end,
        InitialDpRowBelow, % Initial DpRowBelow for the outer foldr (representing dp[M])
        lists:seq(M - 1, 0, -1) % Iterate rows from M-1 down to 0
    ),

    % The `FinalDpRow` is `[dp[0][0], dp[0][1], ..., dp[0][N-1], dp[0][N]]`.
    % We need `dp[0][0]`.
    hd(FinalDpRow).