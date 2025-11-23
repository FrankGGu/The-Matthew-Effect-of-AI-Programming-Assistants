-module(solution).
-export([max_value/1]).

max_value(Grid) ->
    [FirstGridRow | RestGridRows] = Grid,
    DPPrevRow = calc_first_dp_row(FirstGridRow),
    FinalDPRow = lists:foldl(
        fun(CurrentGridRow, AccDPPrevRow) ->
            calc_next_dp_row(CurrentGridRow, AccDPPrevRow)
        end,
        DPPrevRow,
        RestGridRows
    ),
    lists:last(FinalDPRow).

calc_first_dp_row(Row) ->
    {ReversedList, _LastSum} = lists:foldl(
        fun(Val, {Acc, PrevSum}) ->
            CurrentSum = Val + PrevSum,
            {[CurrentSum|Acc], CurrentSum}
        end,
        {[], 0},
        Row
    ),
    lists:reverse(ReversedList).

calc_next_dp_row([GridH|GridT], [PrevDPH|PrevDPT]) ->
    FirstDPVal = GridH + PrevDPH,
    {ReversedDPRow, _LastDPVal} = lists:foldl(
        fun({GridVal, PrevDPVal}, {AccDPRow, PrevColDPVal}) ->
            NewDPVal = GridVal + max(PrevDPVal, PrevColDPVal),
            {[NewDPVal|AccDPRow], NewDPVal}
        end,
        {[FirstDPVal], FirstDPVal},
        lists:zip(GridT, PrevDPT)
    ),
    lists:reverse(ReversedDPRow).