-module(solution).
-export([min_path_cost/2]).

-include_lib("stdlib/include/array.hrl").

min_path_cost(Grid, MoveCost) ->
    M = length(Grid),
    N = length(hd(Grid)),

    ColIndices = lists:seq(0, N - 1),

    MoveCostArray = array:from_list(lists:map(fun array:from_list/1, MoveCost)),

    PrevDPArray = array:from_list(hd(Grid)),
    PrevGridArray = array:from_list(hd(Grid)),

    LastDPArray = solve_rows(tl(Grid), PrevDPArray, PrevGridArray, MoveCostArray, ColIndices, N),

    lists:min(array:to_list(LastDPArray)).

solve_rows([], PrevDPArray, _PrevGridArray, _MoveCostArray, _ColIndices, _N) ->
    PrevDPArray;
solve_rows([CurrentGridRow | RestGridRows], PrevDPArray, PrevGridArray, MoveCostArray, ColIndices, N) ->
    CurrentGridArray = array:from_list(CurrentGridRow),

    DPCurrArray = calculate_dp_row(CurrentGridArray, PrevDPArray, PrevGridArray, MoveCostArray, ColIndices, N),

    solve_rows(RestGridRows, DPCurrArray, CurrentGridArray, MoveCostArray, ColIndices, N).

calculate_dp_row(CurrentGridArray, PrevDPArray, PrevGridArray, MoveCostArray, ColIndices, N) ->
    DPCurrArray = array:new([{size, N}, {fixed, true}]),

    lists:foldl(
        fun(C, AccDPArray) ->
            CurrentCellVal = array:get(C, CurrentGridArray),

            MinPrevPathCost = 
                lists:foldl(
                    fun(PrevC, MinAcc) ->
                        PrevCellDP = array:get(PrevC, PrevDPArray),
                        PrevCellGridVal = array:get(PrevC, PrevGridArray),

                        MoveCostRowArray = array:get(PrevCellGridVal, MoveCostArray),
                        CostToMove = array:get(C, MoveCostRowArray),

                        min(MinAcc, PrevCellDP + CostToMove)
                    end,
                    1_000_000_000,
                    ColIndices
                ),

            array:set(C, CurrentCellVal + MinPrevPathCost, AccDPArray)
        end,
        DPCurrArray,
        ColIndices
    ).