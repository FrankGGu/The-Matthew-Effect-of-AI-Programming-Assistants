-module(solution).
-export([construct_product_matrix/1]).

construct_product_matrix(Grid) ->
    MOD = 12345,

    % Step 1: Calculate PrefixProdMatrix
    % PrefixProdMatrix[r][c] = product of all elements grid[x][y] such that (x < r) OR (x == r AND y < c).
    % This is built by iterating rows from top to bottom, and elements within rows from left to right.
    % The accumulator {CurrentProd, AccRows} holds the running product and the list of rows for PrefixProdMatrix (built in reverse order of rows).
    {_FinalPrefixProd, PrefixProdMatrixReversedRows} = lists:foldl(
        fun(Row, {CurrentProdAcc, AccRows}) ->
            % For each row, calculate prefix products within the row.
            % The accumulator {InnerProdAcc, InnerAccRow} holds the running product for the current row
            % and the list of prefix products for the current row (built in reverse order of elements).
            {NewCurrentProdAcc, CurrentRowPrefixProdsReversed} = lists:foldl(
                fun(Val, {InnerProdAcc, InnerAccRow}) ->
                    { (InnerProdAcc * Val) rem MOD, [InnerProdAcc | InnerAccRow] }
                end,
                {CurrentProdAcc, []},
                Row % Process elements from left to right
            ),
            % CurrentRowPrefixProdsReversed contains [PrefixProd(last_elem), ..., PrefixProd(first_elem)]
            % Reverse it to get [PrefixProd(first_elem), ..., PrefixProd(last_elem)]
            % Add this row to AccRows (which is building in reverse row order)
            {NewCurrentProdAcc, [lists:reverse(CurrentRowPrefixProdsReversed) | AccRows]}
        end,
        {1, []}, % Initial accumulator: running product is 1, no rows yet
        Grid % Process rows from first to last
    ),
    % Reverse the accumulated rows to get the PrefixProdMatrix in correct row order
    PrefixProdMatrix = lists:reverse(PrefixProdMatrixReversedRows),

    % Step 2: Calculate SuffixProdMatrix
    % SuffixProdMatrix[r][c] = product of all elements grid[x][y] such that (x > r) OR (x == r AND y > c).
    % This is built by iterating rows from bottom to top, and elements within rows from right to left.
    % `lists:foldr` on `Grid` processes rows from last to first (conceptually).
    % The accumulator {CurrentProdAcc, AccRows} holds the running product and the list of rows for SuffixProdMatrix (built in correct order of rows).
    {_FinalSuffixProd, SuffixProdMatrix} = lists:foldr(
        fun(Row, {CurrentProdAcc, AccRows}) ->
            % For each row, calculate suffix products within the row.
            % `lists:foldr` on `Row` processes elements from right to left.
            % The accumulator {InnerProdAcc, InnerAccRow} holds the running product for the current row
            % and the list of suffix products for the current row (built in correct order of elements).
            {NewCurrentProdAcc, CurrentRowSuffixProds} = lists:foldr(
                fun(Val, {InnerProdAcc, InnerAccRow}) ->
                    { (InnerProdAcc * Val) rem MOD, [InnerProdAcc | InnerAccRow] }
                end,
                {CurrentProdAcc, []},
                Row % Process elements from right to left
            ),
            % CurrentRowSuffixProds contains [SuffixProd(first_elem), ..., SuffixProd(last_elem)]
            % Add this row to AccRows (which is building in correct row order due to outer foldr)
            {NewCurrentProdAcc, [CurrentRowSuffixProds | AccRows]}
        end,
        {1, []}, % Initial accumulator: running product is 1, no rows yet
        Grid % Process rows from first to last (but foldr processes them effectively last to first)
    ),

    % Step 3: Combine PrefixProdMatrix and SuffixProdMatrix
    % ResultMatrix[r][c] = (PrefixProdMatrix[r][c] * SuffixProdMatrix[r][c]) mod MOD
    ResultMatrix = lists:zipwith(
        fun(PrefixRow, SuffixRow) ->
            lists:zipwith(
                fun(PVal, SVal) ->
                    (PVal * SVal) rem MOD
                end,
                PrefixRow,
                SuffixRow
            )
        end,
        PrefixProdMatrix,
        SuffixProdMatrix
    ),
    ResultMatrix.