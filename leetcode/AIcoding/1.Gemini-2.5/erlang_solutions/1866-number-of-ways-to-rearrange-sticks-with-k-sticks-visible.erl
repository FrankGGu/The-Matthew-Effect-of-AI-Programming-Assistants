-module(solution).
-export([rearrangeSticks/2]).

-define(MOD, 1000000007).

rearrangeSticks(N, K) ->
    % dp_table: array of arrays. dp_table[i] is an array representing row i.
    % dp_table[i][j] stores the number of ways for i sticks and j visible.
    % We use 1-based indexing for N and K in logic, so array sizes N+1, K+1.

    % Create the outer array (for N)
    dp_table = array:new([{fixed, true}, {size, N + 1}]),

    % Initialize each element of dp_table with an inner array (for K)
    % Each inner array represents a row for a given 'i' number of sticks.
    % Default value is 0.
    Initialized_dp_table = lists:foldl(fun(I, CurrentTable) ->
        array:set(I, array:new([{fixed, true}, {size, K + 1}, {default, 0}]), CurrentTable)
    end, dp_table, lists:seq(0, N)), % Initialize rows 0 to N

    % Set base case: dp[0][0] = 1 (0 sticks, 0 visible, 1 way - empty arrangement)
    % This is important for the recurrence when I=1, J=1, as it needs dp[0][0].
    Row0 = array:get(0, Initialized_dp_table),
    Updated_Row0 = array:set(0, 1, Row0),
    CurrentDPTable = array:set(0, Updated_Row0, Initialized_dp_table),

    % Fill the DP table using the recurrence relation
    % Iterate 'i' from 1 to N (number of sticks)
    Filled_dp_table = lists:foldl(fun(I, TableAcc) ->
        % Get the array for the current row 'I'
        I_row = array:get(I, TableAcc),

        % Get the array for the previous row 'I-1'
        Prev_I_row = array:get(I - 1, TableAcc),

        % Iterate 'j' from 1 to K (number of visible sticks)
        Updated_I_row = lists:foldl(fun(J, Current_I_row) ->
            Val = if
                J == 0 ->
                    0; % dp[I][0] = 0 for I > 0
                J > I ->
                    0; % Cannot have more visible sticks than total sticks
                true ->
                    % Recurrence: dp[I][J] = dp[I-1][J-1] + (I-1) * dp[I-1][J]
                    Term1 = array:get(J - 1, Prev_I_row),

                    % Calculate Term2: (I-1) * dp[I-1][J]
                    % Ensure (I-1) is not negative. I starts from 1, so I-1 >= 0.
                    Term2_val = array:get(J, Prev_I_row),
                    Term2 = ((I - 1) * Term2_val) rem ?MOD,

                    (Term1 + Term2) rem ?MOD
            end,
            array:set(J, Val, Current_I_row)
        end, I_row, lists:seq(1, K)), % Iterate J from 1 to K

        array:set(I, Updated_I_row, TableAcc)
    end, CurrentDPTable, lists:seq(1, N)), % Iterate I from 1 to N

    % The final result is dp[N][K]
    array:get(K, array:get(N, Filled_dp_table)).