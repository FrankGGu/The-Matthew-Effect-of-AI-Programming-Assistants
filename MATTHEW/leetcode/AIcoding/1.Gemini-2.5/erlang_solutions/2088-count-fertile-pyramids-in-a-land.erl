-module(solution).
-export([count_fertile_pyramids/1]).

my_max(A, B) when A > B -> A;
my_max(_A, B) -> B.

count_fertile_pyramids(Grid) ->
    R = length(Grid),
    C = length(hd(Grid)),

    GridArrays = lists:map(fun array:from_list/1, Grid),

    {TotalUp, _FinalDpUpRow} = calculate_dp_up_optimized(GridArrays, R, C),

    {TotalInv, _FinalDpInvRow} = calculate_dp_inv_optimized(GridArrays, R, C),

    TotalUp + TotalInv.

calculate_dp_up_optimized(GridArrays, R, C) ->
    % Initialize dp_up_prev_row (for R-1)
    % This will be the row R-1 of the dp_up table.
    % If R=0, this part is skipped. If R=1, this is for row 0.
    DpUpPrevRowArray = array:new([{size, C}]),
    DpUpPrevRowArrayFilled = 
        if R > 0 ->
            GridRowR_1 = array:get(R-1, GridArrays),
            lists:foldl(
                fun(ColIdx, AccDpRow) ->
                    Val = if array:get(ColIdx, GridRowR_1) == 0 -> 0; true -> 1 end,
                    array:set(ColIdx, Val, AccDpRow)
                end,
                DpUpPrevRowArray,
                lists:seq(0, C - 1)
            );
        true -> DpUpPrevRowArray % R=0, empty array
        end,

    TotalUp = 
        if R > 0 ->
            lists:foldl(fun(ColIdx, Acc) -> Acc + my_max(0, array:get(ColIdx, DpUpPrevRowArrayFilled) - 1) end, 0, lists:seq(0, C-1));
        true -> 0 % R=0, no pyramids
        end,

    lists:foldl(
        fun(RowIdx, {AccTotalUp, DpUpPrevRowArray}) ->
            CurrentGridRowArray = array:get(RowIdx, GridArrays),
            NextGridRowArray = array:get(RowIdx + 1, GridArrays), % grid[r+1]

            NewDpUpRowArray = array:new([{size, C}]),
            NewDpUpRowArrayFilled = lists:foldl(
                fun(ColIdx, AccNewDpRow) ->
                    GridCell = array:get(ColIdx, CurrentGridRowArray),
                    Val = if GridCell == 0 -> 0;
                           true ->
                               if ColIdx == 0 or ColIdx == C - 1 -> 1;
                                  true ->
                                      % Check cells in grid for r+1, c-1, c, c+1
                                      GridCell_r1c_1 = array:get(ColIdx - 1, NextGridRowArray),
                                      GridCell_r1c = array:get(ColIdx, NextGridRowArray),
                                      GridCell_r1c1 = array:get(ColIdx + 1, NextGridRowArray),

                                      if GridCell_r1c_1 == 1 andalso GridCell_r1c == 1 andalso GridCell_r1c1 == 1 ->
                                          Dp_r1c_1 = array:get(ColIdx - 1, DpUpPrevRowArray),
                                          Dp_r1c = array:get(ColIdx, DpUpPrevRowArray),
                                          Dp_r1c1 = array:get(ColIdx + 1, DpUpPrevRowArray),
                                          1 + min(Dp_r1c_1, min(Dp_r1c, Dp_r1c1));
                                         true ->
                                             1
                                      end
                               end
                        end,
                    array:set(ColIdx, Val, AccNewDpRow)
                end,
                NewDpUpRowArray,
                lists:seq(0, C - 1)
            ),
            CurrentRowTotal = lists:foldl(fun(ColIdx, Acc) -> Acc + my_max(0, array:get(ColIdx, NewDpUpRowArrayFilled) - 1) end, 0, lists:seq(0, C-1)),
            {AccTotalUp + CurrentRowTotal, NewDpUpRowArrayFilled}
        end,
        {TotalUp, DpUpPrevRowArrayFilled},
        lists:seq(R - 2, 0, -1) % Iterate from R-2 down to 0
    ).

calculate_dp_inv_optimized(GridArrays, R, C) ->
    % Initialize dp_inv_prev_row (for R=0)
    % This will be the row 0 of the dp_inv table.
    % If R=0, this part is skipped. If R=1, this is for row 0.
    DpInvPrevRowArray = array:new([{size, C}]),
    DpInvPrevRowArrayFilled =
        if R > 0 ->
            GridRow0 = array:get(0, GridArrays),
            lists:foldl(
                fun(ColIdx, AccDpRow) ->
                    Val = if array:get(ColIdx, GridRow0) == 0 -> 0; true -> 1 end,
                    array:set(ColIdx, Val, AccDpRow)
                end,
                DpInvPrevRowArray,
                lists:seq(0, C - 1)
            );
        true -> DpInvPrevRowArray % R=0, empty array
        end,

    TotalInv = 
        if R > 0 ->
            lists:foldl(fun(ColIdx, Acc) -> Acc + my_max(0, array:get(ColIdx, DpInvPrevRowArrayFilled) - 1) end, 0, lists:seq(0, C-1));
        true -> 0 % R=0, no pyramids
        end,

    lists:foldl(
        fun(RowIdx, {AccTotalInv, DpInvPrevRowArray}) ->
            CurrentGridRowArray = array:get(RowIdx, GridArrays),
            PrevGridRowArray = array:get(RowIdx - 1, GridArrays), % grid[r-1]

            NewDpInvRowArray = array:new([{size, C}]),
            NewDpInvRowArrayFilled = lists:foldl(
                fun(ColIdx, AccNewDpRow) ->
                    GridCell = array:get(ColIdx, CurrentGridRowArray),
                    Val = if GridCell == 0 -> 0;
                           true ->
                               if ColIdx == 0 or ColIdx == C - 1 -> 1;
                                  true ->
                                      % Check cells in grid for r-1, c-1, c, c+1
                                      GridCell_r_1c_1 = array:get(ColIdx - 1, PrevGridRowArray),
                                      GridCell_r_1c = array:get(ColIdx, PrevGridRowArray),
                                      GridCell_r_1c1 = array:get(ColIdx + 1, PrevGridRowArray),

                                      if GridCell_r_1c_1 == 1 andalso GridCell_r_1c == 1 andalso GridCell_r_1c1 == 1 ->
                                          Dp_r_1c_1 = array:get(ColIdx - 1, DpInvPrevRowArray),
                                          Dp_r_1c = array:get(ColIdx, DpInvPrevRowArray),
                                          Dp_r_1c1 = array:get(ColIdx + 1, DpInvPrevRowArray),
                                          1 + min(Dp_r_1c_1, min(Dp_r_1c, Dp_r_1c1));
                                         true ->
                                             1
                                      end
                               end
                        end,
                    array:set(ColIdx, Val, AccNewDpRow)
                end,
                NewDpInvRowArray,
                lists:seq(0, C - 1)
            ),
            CurrentRowTotal = lists:foldl(fun(ColIdx, Acc) -> Acc + my_max(0, array:get(ColIdx, NewDpInvRowArrayFilled) - 1) end, 0, lists:seq(0, C-1)),
            {AccTotalInv + CurrentRowTotal, NewDpInvRowArrayFilled}
        end,
        {TotalInv, DpInvPrevRowArrayFilled},
        lists:seq(1, R - 1) % Iterate from 1 up to R-1
    ).