-module(solution).
-export([max_fish/1]).

max_fish(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)), % Assumes non-empty grid

    % Convert list of lists to array of arrays for O(1) access
    ArrayGrid = array:from_list([array:from_list(Row) || Row <- Grid]),

    % Start the main loop to iterate through all cells
    % Arguments: R, C, Rows, Cols, ArrayGrid, CurrentMaxFish, VisitedSet
    {MaxFish, _FinalVisited} = max_fish_loop(0, 0, Rows, Cols, ArrayGrid, 0, sets:new(set)),
    MaxFish.

get_fish(ArrayGrid, R, C) ->
    RowArray = array:get(R, ArrayGrid),
    array:get(C, RowArray).

max_fish_loop(R, _C, Rows, _Cols, _ArrayGrid, CurrentMaxFish, Visited) when R >= Rows ->
    {CurrentMaxFish, Visited};
max_fish_loop(R, C, Rows, Cols, ArrayGrid, CurrentMaxFish, Visited) when C >= Cols ->
    max_fish_loop(R + 1, 0, Rows, Cols, ArrayGrid, CurrentMaxFish, Visited);
max_fish_loop(R, C, Rows, Cols, ArrayGrid, CurrentMaxFish, Visited) ->
    FishVal = get_fish(ArrayGrid, R, C),

    if 
        FishVal > 0 andalso not sets:is_element({R, C}, Visited) ->
            {PondFish, NewVisited} = dfs(ArrayGrid, R, C, Rows, Cols, Visited),
            UpdatedMaxFish = max(CurrentMaxFish, PondFish),
            max_fish_loop(R, C + 1, Rows, Cols, ArrayGrid, UpdatedMaxFish, NewVisited);
        true ->
            max_fish_loop(R, C + 1, Rows, Cols, ArrayGrid, CurrentMaxFish, Visited)
    end.

dfs(ArrayGrid, R, C, Rows, Cols, Visited) when R < 0 orelse R >= Rows orelse C < 0 orelse C >= Cols ->
    {0, Visited};
dfs(ArrayGrid, R, C, Rows, Cols, Visited) ->
    FishVal = get_fish(ArrayGrid, R, C),
    if
        FishVal == 0 orelse sets:is_element({R, C}, Visited) ->
            {0, Visited};
        true ->
            NewVisited = sets:add_element({R, C}, Visited),

            {F1, V1} = dfs(ArrayGrid, R + 1, C, Rows, Cols, NewVisited),
            {F2, V2} = dfs(ArrayGrid, R - 1, C, Rows, Cols, V1),
            {F3, V3} = dfs(ArrayGrid, R, C + 1, Rows, Cols, V2),
            {F4, V4} = dfs(ArrayGrid, R, C - 1, Rows, Cols, V3),

            {FishVal + F1 + F2 + F3 + F4, V4}
    end.