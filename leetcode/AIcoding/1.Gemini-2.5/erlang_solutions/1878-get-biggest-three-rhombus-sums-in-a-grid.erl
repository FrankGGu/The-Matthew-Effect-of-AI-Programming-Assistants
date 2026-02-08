-module(solution).
-export([get_biggest_three_rhombus_sums/1]).

list_to_tuple_of_tuples(LoL) ->
    list_to_tuple(lists:map(fun list_to_tuple/1, LoL)).

get_grid_val(GridTuple, R, C) ->
    element(C + 1, element(R + 1, GridTuple)).

build_diagonal_sums(GridTuple, M, N) ->
    % AccDPMainRows and AccDPAntiRows will be lists of lists (representing rows)
    % Each inner list will be a row of DP values
    DPMainRows = lists:foldl(fun(R, AccDPMainRows) ->
        CurrentMainRow = lists:foldl(fun(C, AccCurrentMainRow) ->
            Val = get_grid_val(GridTuple, R, C),
            MainSum = Val + (if R > 0 and C > 0 ->
                                    % Get DPMain[R-1][C-1]
                                    lists:nth(C, lists:nth(R, AccDPMainRows))
                              else 0 end),
            AccCurrentMainRow ++ [MainSum]
        end, [], lists:seq(0, N-1)),
        AccDPMainRows ++ [CurrentMainRow]
    end, [], lists:seq(0, M-1)),

    DPAntiRows = lists:foldl(fun(R, AccDPAntiRows) ->
        CurrentAntiRow = lists:foldl(fun(C, AccCurrentAntiRow) ->
            Val = get_grid_val(GridTuple, R, C),
            AntiSum = Val + (if R > 0 and C < N-1 ->
                                    % Get DPAnti[R-1][C+1]
                                    lists:nth(C + 2, lists:nth(R, AccDPAntiRows))
                              else 0 end),
            AccCurrentAntiRow ++ [AntiSum]
        end, [], lists:seq(0, N-1)),
        AccDPAntiRows ++ [CurrentAntiRow]
    end, [], lists:seq(0, M-1)),

    {list_to_tuple_of_tuples(DPMainRows), list_to_tuple_of_tuples(DPAntiRows)}.

get_main_diag_segment_sum(DPMainTuple, R1, C1, R2, C2) ->
    SumR2C2 = get_grid_val(DPMainTuple, R2, C2),
    SumBefore = if R1 > 0 and C1 > 0 ->
                    get_grid_val(DPMainTuple, R1 - 1, C1 - 1)
                else 0
                end,
    SumR2C2 - SumBefore.

get_anti_diag_segment_sum(DPAntiTuple, R1, C1, R2, C2, N) ->
    SumR2C2 = get_grid_val(DPAntiTuple, R2, C2),
    SumBefore = if R1 > 0 and C1 < N - 1 ->
                    get_grid_val(DPAntiTuple, R1 - 1, C1 + 1)
                else 0
                end,
    SumR2C2 - SumBefore.

calculate_rhombus_sum_optimized(GridTuple, DPMainTuple, DPAntiTuple, _M, N, R, C, Ext) ->
    % Corners (0-indexed):
    % Top: (R_T, C_T) = (R-Ext, C)
    % Left: (R_L, C_L) = (R, C-Ext)
    % Bottom: (R_B, C_B) = (R+Ext, C)
    % Right: (R_R, C_R) = (R, C+Ext)

    % Segment 1 (Top-Left): (R_T, C_T) to (R_L, C_L) - main diagonal
    S1 = get_main_diag_segment_sum(DPMainTuple, R - Ext, C, R, C - Ext),
    % Segment 2 (Left-Bottom): (R_L, C_L) to (R_B, C_B) - main diagonal
    S2 = get_main_diag_segment_sum(DPMainTuple, R, C - Ext, R + Ext, C),
    % Segment 3 (Bottom-Right): (R_B, C_B) to (R_R, C_R) - anti diagonal
    S3 = get_anti_diag_segment_sum(DPAntiTuple, R + Ext, C, R, C + Ext, N),
    % Segment 4 (Right-Top): (R_R, C_R) to (R_T, C_T) - anti diagonal
    S4 = get_anti_diag_segment_sum(DPAntiTuple, R, C + Ext, R - Ext, C, N),

    % Sum of 4 segments. Corners are counted twice. Subtract them once.
    Corner1 = get_grid_val(GridTuple, R - Ext, C),
    Corner2 = get_grid_val(GridTuple, R, C - Ext),
    Corner3 = get_grid_val(GridTuple, R + Ext, C),
    Corner4 = get_grid_val(GridTuple, R, C + Ext),

    S1 + S2 + S3 + S4 - (Corner1 + Corner2 + Corner3 + Corner4).

-spec get_biggest_three_rhombus_sums(Grid :: [[integer()]]) -> [integer()].
get_biggest_three_rhombus_sums(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    GridTuple = list_to_tuple_of_tuples(Grid),

    {DPMainTuple, DPAntiTuple} = build_diagonal_sums(GridTuple, M, N),

    Sums = sets:new(), % Use a set to store unique sums

    lists:foldl(fun(R, AccSums1) ->
        lists:foldl(fun(C, AccSums2) ->
            % Rhombus with extent 0 (single cell)
            CellVal = get_grid_val(GridTuple, R, C),
            NewSums1 = sets:add_element(CellVal, AccSums2),

            MaxExtentR = min(R, M - 1 - R),
            MaxExtentC = min(C, N - 1 - C),
            MaxExtent = min(MaxExtentR, MaxExtentC),

            lists:foldl(fun(Ext, AccSums3) ->
                RhombusSum = calculate_rhombus_sum_optimized(GridTuple, DPMainTuple, DPAntiTuple, M, N, R, C, Ext),
                sets:add_element(RhombusSum, AccSums3)
            end, NewSums1, lists:seq(1, MaxExtent)) % Extent starts from 1
        end, AccSums1, lists:seq(0, N - 1))
    end, Sums, lists:seq(0, M - 1)),

    SortedSums = lists:sort(fun(A, B) -> A > B end, sets:to_list(Sums)),
    lists:sublist(SortedSums, min(3, length(SortedSums))).