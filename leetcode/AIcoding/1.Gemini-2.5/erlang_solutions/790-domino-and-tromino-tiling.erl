-module(solution).
-export([num_tilings/1]).

num_tilings(N) ->
    Mod = 1000000007,

    case N of
        1 -> 1;
        2 -> 2;
        _ -> % N >= 3
            % The recurrence relation is dp[i] = 2 * dp[i-1] + dp[i-3]
            % Base values for the helper function:
            % dp[0] = 1 (conceptually, used as DpI_3 for dp[3])
            % dp[1] = 1 (used as DpI_2 for dp[3])
            % dp[2] = 2 (used as DpI_1 for dp[3])
            dp_helper(3, 1, 1, 2, N, Mod)
    end.

dp_helper(CurrentI, DpI_3, DpI_2, DpI_1, TargetN, Mod) ->
    if CurrentI > TargetN ->
        DpI_1;
    else
        % Calculate dp[CurrentI] = (2 * dp[CurrentI-1] + dp[CurrentI-3]) % Mod
        DpI = (2 * DpI_1 + DpI_3) rem Mod,
        % Recurse with updated values:
        % New DpI_3 is old DpI_2
        % New DpI_2 is old DpI_1
        % New DpI_1 is the newly calculated DpI
        dp_helper(CurrentI + 1, DpI_2, DpI_1, DpI, TargetN, Mod)
    end.