-module(solution).
-export([max_score_from_grid_operations/1]).

max_score_from_grid_operations(Grid) ->
    MinVal = -2000000000000, 

    find_max_two_and_idx(List) ->
        find_max_two_and_idx(List, 0, MinVal, -1, MinVal).

    find_max_two_and_idx([], _CurrentIdx, Max1, Idx1, Max2) ->
        {Max1, Idx1, Max2};
    find_max_two_and_idx([H|T], CurrentIdx, Max1, Idx1, Max2) ->
        if H > Max1 ->
            find_max_two_and_idx(T, CurrentIdx + 1, H, CurrentIdx, Max1);
        H > Max2 andalso CurrentIdx =/= Idx1 ->
            find_max_two_and_idx(T, CurrentIdx + 1, Max1, Idx1, H);
        true ->
            find_max_two_and_idx(T, CurrentIdx + 1, Max1, Idx1, Max2)
        end.

    dp_prev = hd(Grid),
    CurrentGrid = tl(Grid),

    FinalDp = lists:foldl(
        fun(Row, AccDpPrev) ->
            {Max1, Idx1, Max2} = find_max_two_and_idx(AccDpPrev),

            dp_current = lists:mapi(
                fun(C, Val) ->
                    PrevDpC = lists:nth(C + 1, AccDpPrev), 

                    MaxFromPrevRow = 
                        if C == Idx1 -> Max2;
                        true -> Max1
                        end,

                    max(Val + MaxFromPrevRow, PrevDpC)
                end,
                Row
            ),
            dp_current
        end,
        dp_prev,
        CurrentGrid
    ),

    lists:max(FinalDp).