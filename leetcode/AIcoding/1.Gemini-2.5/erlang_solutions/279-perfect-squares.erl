-module(solution).
-export([numSquares/1]).

numSquares(N) ->
    % Create an array of size N+1 to store DP values.
    % dp[i] will store the minimum number of perfect squares that sum up to i.
    % Initialize dp[0] = 0, and all other dp[i] to a value larger than any possible result (e.g., N+1).
    % N+1 is a safe upper bound because the maximum number of squares needed is N (e.g., 1+1+...+1 for N times).
    DPArray = array:new([{size, N+1}, {fixed, true}]),

    % Set dp[0] to 0 and all other elements to N+1
    InitialDPArray = array:set(0, 0,
        lists:foldl(
            fun(Idx, Arr) -> array:set(Idx, N+1, Arr) end,
            DPArray,
            lists:seq(1, N)
        )
    ),

    % Iterate from i = 1 to N to fill the DP array
    FinalDPArray = lists:foldl(
        fun(I, CurrentArr) ->
            % Calculate the maximum integer J such that J*J <= I
            MaxJ = floor(math:sqrt(I)),

            % Calculate dp[I] = min(dp[I - j*j] + 1) for all j from 1 to MaxJ
            MinVal = lists:foldl(
                fun(J, AccMin) ->
                    J_Squared = J * J,
                    PrevVal = array:get(I - J_Squared, CurrentArr),
                    min(AccMin, PrevVal + 1)
                end,
                N + 1, % Initialize current minimum for dp[I] with a large value
                lists:seq(1, MaxJ)
            ),
            array:set(I, MinVal, CurrentArr)
        end,
        InitialDPArray,
        lists:seq(1, N)
    ),

    % The result is dp[N]
    array:get(N, FinalDPArray).