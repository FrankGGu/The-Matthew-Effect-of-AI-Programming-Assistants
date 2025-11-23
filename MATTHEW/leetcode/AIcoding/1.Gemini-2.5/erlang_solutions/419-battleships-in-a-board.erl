-module(solution).
-export([count_battleships/1]).

-spec count_battleships(Board :: [[char()]]) -> integer().
count_battleships(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),

    BoardArray = array:from_list([array:from_list(Row) || Row <- Board]),

    count_ships_array_iter(BoardArray, Rows, Cols, 0, 0, 0).

count_ships_array_iter(_BoardArray, Rows, _Cols, R, _C, Count) when R == Rows ->
    Count;
count_ships_array_iter(BoardArray, Rows, Cols, R, C, Count) ->
    Char = array:get(C, array:get(R, BoardArray)),

    NewCount = if Char == $\X ->
                   IsTopX = (R > 0) andalso (array:get(C, array:get(R - 1, BoardArray)) == $\X),
                   IsLeftX = (C > 0) andalso (array:get(C - 1, array:get(R, BoardArray)) == $\X),
                   if not IsTopX andalso not IsLeftX ->
                       Count + 1;
                      true ->
                       Count
                   end;
                  true ->
                   Count
               end,

    NextR = if C == Cols - 1 -> R + 1; true -> R end,
    NextC = if C == Cols - 1 -> 0; true -> C + 1 end,

    count_ships_array_iter(BoardArray, Rows, Cols, NextR, NextC, NewCount).