-module(solution).
-export([max_large_island/1]).

max_large_island(Grid) ->
    N = length(Grid),

    InitialIslandID = 2, % Start island IDs from 2 to distinguish from 0 (water) and 1 (unvisited land)
    InitialIslandSizes = #{},
    InitialMaxExistingIslandSize = 0,

    % Pass 1: Find all existing islands
    % find_islands_loop(R, C, N, CurrentGrid, IslandIDCounter, IslandSizesMap, MaxExistingIslandSize)
    {FinalModifiedGrid, FinalIslandSizes, MaxExistingIslandSize} = 
        find_islands_loop(0, 0, N, Grid, InitialIslandID, InitialIslandSizes, InitialMaxExistingIslandSize),

    % Initialize OverallMax with MaxExistingIslandSize.
    % This handles cases where there are no 0s to flip (all 1s) or only 0s.
    OverallMax = MaxExistingIslandSize,

    % Pass 2: Try flipping 0s
    % try_flip_zeros_loop(R, C, N, ModifiedGrid, IslandSizesMap, CurrentOverallMax)
    try_flip_zeros_loop(0, 0, N, FinalModifiedGrid, FinalIslandSizes, OverallMax).

set_grid_val(RowIndex, ColIndex, Value, Grid) ->
    OldRow = lists:nth(RowIndex + 1, Grid),
    NewRow = lists:replace_nth(ColIndex + 1, Value, OldRow),
    lists:replace_nth(RowIndex + 1, NewRow, Grid).

get_grid_val(RowIndex, ColIndex, Grid) ->
    lists:nth(ColIndex + 1, lists:nth(RowIndex + 1, Grid)).

dfs(R, C, IslandID, Grid, N) ->
    % Use a list as a stack for DFS traversal
    dfs_helper([{R, C}], IslandID, Grid, N, 0).

dfs_helper([], _IslandID, Grid, _N, AccSize) ->
    {AccSize, Grid};
dfs_helper([{R, C} | RestStack], IslandID, Grid, N, AccSize) ->
    % Check if this cell is valid and is '1' (unvisited land)
    case (R >= 0 and R < N and C >= 0 and C < N) andalso (get_grid_val(R, C, Grid) == 1) of
        true ->
            % Mark cell with IslandID
            NewGrid = set_grid_val(R, C, IslandID, Grid),
            NewAccSize = AccSize + 1,

            % Add neighbors to the stack (DFS)
            Neighbors = get_neighbors(R, C, N),
            NewStack = Neighbors ++ RestStack, % Prepend for DFS (stack behavior)

            dfs_helper(NewStack, IslandID, NewGrid, N, NewAccSize);
        false ->
            % Already visited, water, or out of bounds, skip
            dfs_helper(RestStack, IslandID, Grid, N, AccSize)
    end.

get_neighbors(R, C, N) ->
    PotentialNeighbors = [{R - 1, C}, {R + 1, C}, {R, C - 1}, {R, C + 1}],
    lists:filter(fun({NR, NC}) -> NR >= 0 and NR < N and NC >= 0 and NC < N end, PotentialNeighbors).

find_islands_loop(R, C, N, Grid, IslandIDCounter, IslandSizes, MaxExistingIslandSize) when R < N ->
    CellVal = get_grid_val(R, C, Grid),

    case CellVal of
        1 -> % Found unvisited land
            {IslandSize, NewGrid} = dfs(R, C, IslandIDCounter, Grid, N),
            NewIslandSizes = maps:put(IslandIDCounter, IslandSize, IslandSizes),
            NewMaxExistingIslandSize = max(MaxExistingIslandSize, IslandSize),

            NextIslandIDCounter = IslandIDCounter + 1,

            % Move to next cell in the grid
            next_cell_find_islands(R, C, N, NewGrid, NextIslandIDCounter, NewIslandSizes, NewMaxExistingIslandSize);
        _ -> % Water (0) or already visited land (IslandID > 1)
            next_cell_find_islands(R, C, N, Grid, IslandIDCounter, IslandSizes, MaxExistingIslandSize)
    end;
find_islands_loop(_R, _C, _N, Grid, _IslandIDCounter, IslandSizes, MaxExistingIslandSize) ->
    % All cells processed
    {Grid, IslandSizes, MaxExistingIslandSize}.

next_cell_find_islands(R, C, N, Grid, IslandIDCounter, IslandSizes, MaxExistingIslandSize) ->
    if C + 1 < N ->
        find_islands_loop(R, C + 1, N, Grid, IslandIDCounter, IslandSizes, MaxExistingIslandSize);
    true -> % C + 1 == N, move to next row
        find_islands_loop(R + 1, 0, N, Grid, IslandIDCounter, IslandSizes, MaxExistingIslandSize)
    end.

try_flip_zeros_loop(R, C, N, Grid, IslandSizes, OverallMax) when R < N ->
    CellVal = get_grid_val(R, C, Grid),

    NewOverallMax = 
        case CellVal of
            0 -> % Found a water cell, try flipping it
                AdjacentIslandIDs = sets:new(),

                Neighbors = get_neighbors(R, C, N),
                % Collect unique IslandIDs of adjacent islands
                FinalAdjacentIslandIDs = lists:foldl(
                    fun({NR, NC}, AccIDs) ->
                        NeighborVal = get_grid_val(NR, NC, Grid),
                        case NeighborVal > 1 of % It's an IslandID
                            true -> sets:add_element(NeighborVal, AccIDs);
                            false -> AccIDs
                        end
                    end,
                    AdjacentIslandIDs,
                    Neighbors
                ),

                % Calculate total size if this 0 is flipped
                CurrentIslandSize = 1, % for the flipped cell itself
                TotalConnectedSize = lists:foldl(
                    fun(ID, AccSize) -> AccSize + maps:get(ID, IslandSizes) end,
                    CurrentIslandSize,
                    sets:to_list(FinalAdjacentIslandIDs)
                ),
                max(OverallMax, TotalConnectedSize);
            _ -> % Not a 0, no flip possible here
                OverallMax
        end,

    % Move to next cell in the grid
    next_cell_try_flip_zeros(R, C, N, Grid, IslandSizes, NewOverallMax);
try_flip_zeros_loop(_R, _C, _N, _Grid, _IslandSizes, OverallMax) ->
    OverallMax.

next_cell_try_flip_zeros(R, C, N, Grid, IslandSizes, OverallMax) ->
    if C + 1 < N ->
        try_flip_zeros_loop(R, C + 1, N, Grid, IslandSizes, OverallMax);
    true -> % C + 1 == N, move to next row
        try_flip_zeros_loop(R + 1, 0, N, Grid, IslandSizes, OverallMax)
    end.