-module(solution).
-export([getMoneyAmount/1]).

getMoneyAmount(N) ->
    % dp_table is an array of arrays.
    % dp_table[i] will be an array representing the i-th row.
    % Each element dp_table[i][j] stores the minimum money to guarantee a win for numbers in range [i, j].
    % Initialize all elements to 0.
    InitialRow = array:new([{size, N + 1}, {default, 0}]),
    DpTable = array:new([{size, N + 1}, {default, InitialRow}]),

    % Length is the length of the subproblem range (j - i)
    % Loop for length from 1 to N-1
    % Length = 1 means range [i, i+1]
    % Length = N-1 means range [1, N]
    lists:foldl(fun(Len, CurrentDpTable) ->
        lists:foldl(fun(I, InnerCurrentDpTable) ->
            J = I + Len,
            % Calculate dp[I][J]
            % dp[I][J] = min_{K=I to J} (K + max(dp[I][K-1], dp[K+1][J]))
            MinCost = calculate_min_cost(I, J, InnerCurrentDpTable),

            % Update DpTable: Get the row array for I, update J-th element, then set the row back.
            RowI = array:get(I, InnerCurrentDpTable),
            UpdatedRowI = array:set(J, MinCost, RowI),
            array:set(I, UpdatedRowI, InnerCurrentDpTable)
        end, CurrentDpTable, lists:seq(1, N - Len))
    end, DpTable, lists:seq(1, N - 1)),

    % The result is dp[1][N]
    Row1 = array:get(1, DpTable),
    array:get(N, Row1).

calculate_min_cost(I, J, DpTable) ->
    % Initialize MinCost with a very large number (infinity)
    lists:foldl(fun(K, AccMinCost) ->
        % Cost for the left subproblem [I, K-1]
        CostLeft = if K - 1 < I -> 0; % Range is invalid or empty
                   true -> 
                       RowI = array:get(I, DpTable),
                       array:get(K - 1, RowI)
                   end,
        % Cost for the right subproblem [K+1, J]
        CostRight = if K + 1 > J -> 0; % Range is invalid or empty
                    true -> 
                        RowKplus1 = array:get(K + 1, DpTable),
                        array:get(J, RowKplus1)
                    end,

        % Current cost if K is chosen as the guess
        CurrentCost = K + max(CostLeft, CostRight),
        min(AccMinCost, CurrentCost)
    end, infinity, lists:seq(I, J)).