-module(solution).
-export([max_value_sum/1]).

-define(MIN_VAL, -1000000000000000).

get_grid_val(Grid, R, C, M, N) ->
    if R < 0 or R >= M or C < 0 or C >= N -> ?MIN_VAL;
       true -> lists:nth(C + 1, lists:nth(R + 1, Grid))
    end.

fill_top_left_max_impl(Grid, M, N) ->
    TopLeft = array:new([{fixed, true}, {size, M+1}]),
    lists:foldl(fun(R, AccR) ->
        RowArr = array:new([{fixed, true}, {size, N+1}]),
        NewRowArr = lists:foldl(fun(C, AccC) ->
            ValRC = get_grid_val(Grid, R-1, C-1, M, N), % grid[R-1][C-1]
            PrevRMax = if R > 0 -> array:get(C, array:get(R-1, AccR)); true -> ?MIN_VAL end, % TopLeft[R-1][C]
            PrevCMax = if C > 0 -> array:get(C-1, AccC); true -> ?MIN_VAL end, % TopLeft[R][C-1]
            MaxVal = lists:max([ValRC, PrevRMax, PrevCMax, ?MIN_VAL]),
            array:set(C, MaxVal, AccC)
        end, RowArr, lists:seq(0, N)),
        array:set(R, NewRowArr, AccR)
    end, TopLeft, lists:seq(0, M)).

fill_top_right_max_impl(Grid, M, N) ->
    TopRight = array:new([{fixed, true}, {size, M+1}]),
    lists:foldl(fun(R, AccR) ->
        RowArr = array:new([{fixed, true}, {size, N+1}]),
        NewRowArr = lists:foldl(fun(C, AccC) ->
            ValRC = get_grid_val(Grid, R-1, C, M, N), % grid[R-1][C]
            PrevRMax = if R > 0 -> array:get(C, array:get(R-1, AccR)); true -> ?MIN_VAL end, % TopRight[R-1][C]
            PrevCMax = if C < N -> array:get(C+1, AccC); true -> ?MIN_VAL end, % TopRight[R][C+1]
            MaxVal = lists:max([ValRC, PrevRMax, PrevCMax, ?MIN_VAL]),
            array:set(C, MaxVal, AccC)
        end, RowArr, lists:seq(N, 0, -1)), % Iterate C from N down to 0
        array:set(R, NewRowArr, AccR)
    end, TopRight, lists:seq(0, M)).

fill_bottom_left_max_impl(Grid, M, N) ->
    BottomLeft = array:new([{fixed, true}, {size, M+1}]),
    lists:foldl(fun(R, AccR) ->
        RowArr = array:new([{fixed, true}, {size, N+1}]),
        NewRowArr = lists:foldl(fun(C, AccC) ->
            ValRC = get_grid_val(Grid, R, C-1, M, N), % grid[R][C-1]
            PrevRMax = if R < M -> array:get(C, array:get(R+1, AccR)); true -> ?MIN_VAL end, % BottomLeft[R+1][C]
            PrevCMax = if C > 0 -> array:get(C-1, AccC); true -> ?MIN_VAL end, % BottomLeft[R][C-1]
            MaxVal = lists:max([ValRC, PrevRMax, PrevCMax, ?MIN_VAL]),
            array:set(C, MaxVal, AccC)
        end, RowArr, lists:seq(0, N)),
        array:set(R, NewRowArr, AccR)
    end, BottomLeft, lists:seq(M, 0, -1)). % Iterate R from M down to 0

fill_bottom_right_max_impl(Grid, M, N) ->
    BottomRight = array:new([{fixed, true}, {size, M+1}]),
    lists:foldl(fun(R, AccR) ->
        RowArr = array:new([{fixed, true}, {size, N+1}]),
        NewRowArr = lists:foldl(fun(C, AccC) ->
            ValRC = get_grid_val(Grid, R, C, M, N), % grid[R][C]
            PrevRMax = if R < M -> array:get(C, array:get(R+1, AccR)); true -> ?MIN_VAL end, % BottomRight[R+1][C]
            PrevCMax = if C < N -> array:get(C+1, AccC); true -> ?MIN_VAL end, % BottomRight[R][C+1]
            MaxVal = lists:max([ValRC, PrevRMax, PrevCMax, ?MIN_VAL]),
            array:set(C, MaxVal, AccC)
        end, RowArr, lists:seq(N, 0, -1)), % Iterate C from N down to 0
        array:set(R, NewRowArr, AccR)
    end, BottomRight, lists:seq(M, 0, -1)). % Iterate R from M down to 0

compute_max_val_except_row_col(R, C, M, N, TopLeftMax, TopRightMax, BottomLeftMax, BottomRightMax, Acc) ->
    if R == M -> Acc;
       C == N -> compute_max_val_except_row_col(R + 1, 0, M, N, TopLeftMax, TopRightMax, BottomLeftMax, BottomRightMax, Acc);
       true ->
            MaxVal = lists:max([
                array:get(C, array:get(R, TopLeftMax)),        % Max in grid[0..R-1][0..C-1]
                array:get(C + 1, array:get(R, TopRightMax)),   % Max in grid[0..R-1][C+1..N-1]
                array:get(C, array:get(R + 1, BottomLeftMax)), % Max in grid[R+1..M-1][0..C-1]
                array:get(C + 1, array:get(R + 1, BottomRightMax)), % Max in grid[R+1..M-1][C+1..N-1]
                ?MIN_VAL
            ]),
            RowArr = if array:is_defined(R, Acc) -> array:get(R, Acc); true -> array:new([{fixed, true}, {size, N}]) end,
            NewRowArr = array:set(C, MaxVal, RowArr),
            NewAcc = array:set(R, NewRowArr, Acc),
            compute_max_val_except_row_col(R, C + 1, M, N, TopLeftMax, TopRightMax, BottomLeftMax, BottomRightMax, NewAcc)
    end.

compute_max_2_rooks_except_row_col(R_excl, C_excl, M, N, Grid, MaxValExceptRowCol, Acc) ->
    if R_excl == M -> Acc;
       C_excl == N -> compute_max_2_rooks_except_row_col(R_excl + 1, 0, M, N, Grid, MaxValExceptRowCol, Acc);
       true ->
            MaxForThisExclusion =
                lists:foldl(fun(R_i, AccR_i) ->
                    lists:foldl(fun(C_i, AccC_i) ->
                        if R_i == R_excl or C_i == C_excl -> AccC_i;
                           true ->
                                ValR_iC_i = get_grid_val(Grid, R_i, C_i, M, N),
                                ValR3C3 = array:get(C_i, array:get(R_i, MaxValExceptRowCol)),
                                lists:max([AccC_i, ValR_iC_i + ValR3C3])
                        end
                    end, AccR_i, lists:seq(0, N-1))
                end, ?MIN_VAL, lists:seq(0, M-1)),

            RowArr = if array:is_defined(R_excl, Acc) -> array:get(R_excl, Acc); true -> array:new([{fixed, true}, {size, N}]) end,
            NewRowArr = array:set(C_excl, MaxForThisExclusion, RowArr),
            NewAcc = array:set(R_excl, NewRowArr, Acc),
            compute_max_2_rooks_except_row_col(R_excl, C_excl + 1, M, N, Grid, MaxValExceptRowCol, NewAcc)
    end.

compute_final_sum(R, C, M, N, Grid, Max2RooksExceptRowCol, MaxOverallSum) ->
    if R == M -> MaxOverallSum;
       C == N -> compute_final_sum(R + 1, 0, M, N, Grid, Max2RooksExceptRowCol, MaxOverallSum);
       true ->
            ValRC = get_grid_val(Grid, R, C, M, N),
            Val2Rooks = array:get(C, array:get(R, Max2RooksExceptRowCol)),
            NewMaxOverallSum = lists:max([MaxOverallSum, ValRC + Val2Rooks]),
            compute_final_sum(R, C + 1, M, N, Grid, Max2RooksExceptRowCol, NewMaxOverallSum)
    end.

max_value_sum(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    % Step 1: Precompute TopLeftMax, TopRightMax, BottomLeftMax, BottomRightMax
    % These are (M+1)x(N+1) arrays.
    TopLeftMax = fill_top_left_max_impl(Grid, M, N),
    TopRightMax = fill_top_right_max_impl(Grid, M, N),
    BottomLeftMax = fill_bottom_left_max_impl(Grid, M, N),
    BottomRightMax = fill_bottom_right_max_impl(Grid, M, N),

    % Step 2: Compute MaxValExceptRowCol[r][c]
    % This is an M x N array.
    MaxValExceptRowCol = compute_max_val_except_row_col(0, 0, M, N, TopLeftMax, TopRightMax, BottomLeftMax, BottomRightMax, array:new([{fixed, true}, {size, M}])),

    % Step 3: Compute Max2RooksExceptRowCol[r_excl][c_excl]
    % This is an M x N array.
    Max2RooksExceptRowCol = compute_max_2_rooks_except_row_col(0, 0, M, N, Grid, MaxValExceptRowCol, array:new([{fixed, true}, {size, M}])),

    % Step 4: Compute final answer
    compute_final_sum(0, 0, M, N, Grid, Max2RooksExceptRowCol, ?MIN_VAL).