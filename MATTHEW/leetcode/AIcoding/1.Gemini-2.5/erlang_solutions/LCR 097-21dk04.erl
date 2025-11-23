-module(solution).
-export([numDistinct/2]).

numDistinct(S, T) ->
    N = string:len(S),
    M = string:len(T),

    % dp[j] will store the number of distinct subsequences of S[...i-1] that equal T[0...j-1]
    % We use two arrays: one for the previous row (dp_prev) and one for the current row (dp_curr)
    % The array module is 0-indexed.

    % Initialize dp_prev (for i=0): dp_prev[0]=1, dp_prev[j]=0 for j>0
    % This handles the base case where T is an empty string (M=0), which is a subsequence in 1 way.
    dp_prev = array:set(0, 1, array:new([{size, M + 1}, {default, 0}])),

    % Iterate for S (from i=1 to N)
    FinalDP = lists:foldl(fun(I, CurrentDP_prev) ->
        % S_char is S[I-1] (using 1-indexed lists:nth for 0-indexed string character)
        S_char = lists:nth(I, S),

        % Create dp_curr for dp[I][...]
        % dp_curr[0] must be 1 (empty T is always a subsequence of any S prefix)
        dp_curr = array:set(0, 1, array:new([{size, M + 1}, {default, 0}])),

        % Iterate for T (from j=1 to M)
        lists:foldl(fun(J, AccDP_curr) ->
            % T_char is T[J-1] (using 1-indexed lists:nth for 0-indexed string character)
            T_char = lists:nth(J, T),

            % Get dp[I-1][J] (value from previous row, same column)
            Val_prev_row_same_col = array:get(J, CurrentDP_prev),

            % Get dp[I-1][J-1] (value from previous row, previous column)
            Val_prev_row_prev_col = array:get(J - 1, CurrentDP_prev),

            NewVal = if S_char == T_char ->
                            Val_prev_row_prev_col + Val_prev_row_same_col
                     else
                            Val_prev_row_same_col
                     end,
            array:set(J, NewVal, AccDP_curr)
        end, dp_curr, lists:seq(1, M))
    end, dp_prev, lists:seq(1, N)),

    % The final answer is dp[N][M], which is array:get(M, FinalDP)
    array:get(M, FinalDP).