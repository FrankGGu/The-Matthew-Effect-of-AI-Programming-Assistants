-module(solution).
-export([num_islands/1]).

num_islands(Grid) ->
    Rows = length(Grid),
    Cols = if Rows > 0 -> length(hd(Grid));
              true -> 0
           end,

    % Convert list of lists to array of arrays for O(1) access
    ArrayGrid = array:from_list(
                  [array:from_list(Row) || Row <- Grid]
                ),

    count_islands(ArrayGrid, Rows, Cols, 0, 0, 0, gb_sets:new()).

count_islands(_ArrayGrid, Rows, _Cols, Rows, _CurrentCol, IslandCount, _VisitedSet) ->
    IslandCount;
count_islands(ArrayGrid, Rows, Cols, CurrentRow, Cols, IslandCount, VisitedSet) ->
    count_islands(ArrayGrid, Rows, Cols, CurrentRow + 1, 0, IslandCount, VisitedSet);
count_islands(ArrayGrid, Rows, Cols, CurrentRow, CurrentCol, IslandCount, VisitedSet) ->
    if gb_sets:is_member({CurrentRow, CurrentCol}, VisitedSet) ->
        count_islands(ArrayGrid, Rows, Cols, CurrentRow, CurrentCol + 1, IslandCount, VisitedSet);
    true ->
        RowArray = array:get(CurrentRow, ArrayGrid),
        Char = array:get(CurrentCol, RowArray),

        if Char == $1 ->
            NewIslandCount = IslandCount + 1,
            NewVisitedSet = dfs(ArrayGrid, Rows, Cols, CurrentRow, CurrentCol, VisitedSet),
            count_islands(ArrayGrid, Rows, Cols, CurrentRow, CurrentCol + 1, NewIslandCount, NewVisitedSet);
        true ->
            NewVisitedSet = gb_sets:add({CurrentRow, CurrentCol}, VisitedSet),
            count_islands(ArrayGrid, Rows, Cols, CurrentRow, CurrentCol + 1, IslandCount, NewVisitedSet)
        end
    end.

dfs(ArrayGrid, Rows, Cols, R, C, VisitedSet) ->
    NewVisitedSet = gb_sets:add({R, C}, VisitedSet),
    Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],

    lists:foldl(fun({NR, NC}, AccVisitedSet) ->
        if NR >= 0, NR < Rows, NC >= 0, NC < Cols,
           gb_sets:is_member({NR, NC}, AccVisitedSet) == false ->
            RowArray = array:get(NR, ArrayGrid),
            Char = array:get(NC, RowArray),
            if Char == $1 ->
                dfs(ArrayGrid, Rows, Cols, NR, NC, AccVisitedSet);
            true ->
                AccVisitedSet
            end;
        true ->
            AccVisitedSet
        end
    end, NewVisitedSet, Neighbors).