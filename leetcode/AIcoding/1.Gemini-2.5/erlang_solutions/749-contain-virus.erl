-module(solution).
-export([containVirus/1]).

list_to_array_grid(GridList) ->
    Rows = length(GridList),
    Cols = length(hd(GridList)),
    RowArrays = [array:from_list(Row) || Row <- GridList],
    array:from_list(RowArrays).

get_cell(GridArray, R, C) ->
    RowArray = array:get(R, GridArray),
    array:get(C, RowArray).

set_cell(GridArray, R, C, Val) ->
    RowArray = array:get(R, GridArray),
    NewRowArray = array:set(C, Val, RowArray),
    array:set(R, NewRowArray, GridArray).

containVirus(GridList) ->
    Grid = list_to_array_grid(GridList),
    Rows = array:size(Grid),
    Cols = array:size(array:get(0, Grid)),
    containVirus_loop(Grid, Rows, Cols, 0).

containVirus_loop(Grid, Rows, Cols, TotalWalls) ->
    {Regions, _FinalVisited} = find_regions_and_prepare_grid(Grid, Rows, Cols),

    SpreadableRegions = [R || R = {_Cells, Uninfected, _Walls} <- Regions, length(Uninfected) > 0],

    case SpreadableRegions of
        [] ->
            TotalWalls;
        _ ->
            BestRegion = lists:foldl(fun({_CellsA, UninfectedA, _WallsA} = R_A, Acc) ->
                                            {_CellsB, UninfectedB, _WallsB} = Acc,
                                            case length(UninfectedA) > length(UninfectedB) of
                                                true -> R_A;
                                                false -> Acc
                                            end
                                    end, hd(SpreadableRegions), tl(SpreadableRegions)),

            {BestCells, _BestUninfected, BestWalls} = BestRegion,

            NewTotalWalls = TotalWalls + BestWalls,

            GridAfterContainment = lists:foldl(fun({R, C}, CurrentGrid) ->
                                                    set_cell(CurrentGrid, R, C, -1)
                                                end, Grid, BestCells),

            GridAfterSpread = lists:foldl(fun(Region, CurrentGrid) ->
                                                case Region == BestRegion of
                                                    true -> CurrentGrid;
                                                    false ->
                                                        {_OtherCells, OtherUninfected, _OtherWalls} = Region,
                                                        lists:foldl(fun({R, C}, G) ->
                                                                        case get_cell(G, R, C) of
                                                                            0 -> set_cell(G, R, C, 2);
                                                                            _ -> G
                                                                        end
                                                                    end, CurrentGrid, OtherUninfected)
                                                end
                                        end, GridAfterContainment, Regions),

            FinalGrid = finalize_spread(GridAfterSpread, Rows, Cols),

            containVirus_loop(FinalGrid, Rows, Cols, NewTotalWalls)
    end.

get_neighbors(R, C, Rows, Cols) ->
    Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],
    lists:filter(fun({NR, NC}) ->
                        NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols
                 end, Neighbors).

bfs_region(Grid, StartR, StartC, Rows, Cols, InitialVisited) ->
    Queue = queue:new(),
    Queue1 = queue:in({StartR, StartC}, Queue),

    RegionCells = gb_sets:new(),
    UninfectedNeighbors = gb_sets:new(),
    WallsCount = 0,

    CurrentVisited = gb_sets:add({StartR, StartC}, InitialVisited),

    bfs_region_loop(Queue1, Grid, Rows, Cols, RegionCells, UninfectedNeighbors, WallsCount, CurrentVisited).

bfs_region_loop(Queue, Grid, Rows, Cols, RegionCells, UninfectedNeighbors, WallsCount, CurrentVisited) ->
    case queue:is_empty(Queue) of
        true ->
            {gb_sets:to_list(RegionCells), gb_sets:to_list(UninfectedNeighbors), WallsCount, CurrentVisited};
        false ->
            {{R, C}, NewQueue} = queue:out(Queue),

            NewRegionCells = gb_sets:add({R, C}, RegionCells),

            Neighbors = get_neighbors(R, C, Rows, Cols),

            {NextQueue, NextUninfectedNeighbors, NextWallsCount, NextVisited} = 
                lists:foldl(fun({NR, NC}, {AccQueue, AccUninfected, AccWalls, AccVisited}) ->
                                    CellValue = get_cell(Grid, NR, NC),
                                    case CellValue of
                                        1 ->
                                            case gb_sets:is_member({NR, NC}, AccVisited) of
                                                true -> {AccQueue, AccUninfected, AccWalls, AccVisited};
                                                false ->
                                                    NewAccVisited = gb_sets:add({NR, NC}, AccVisited),
                                                    NewAccQueue = queue:in({NR, NC}, AccQueue),
                                                    {NewAccQueue, AccUninfected, AccWalls, NewAccVisited}
                                            end;
                                        0 ->
                                            {AccQueue, gb_sets:add({NR, NC}, AccUninfected), AccWalls + 1, AccVisited};
                                        _ ->
                                            {AccQueue, AccUninfected, AccWalls, AccVisited}
                                    end
                            end, {NewQueue, UninfectedNeighbors, WallsCount, CurrentVisited}, Neighbors),

            bfs_region_loop(NextQueue, Grid, Rows, Cols, NewRegionCells, NextUninfectedNeighbors, NextWallsCount, NextVisited)
    end.

find_regions_and_prepare_grid(Grid, Rows, Cols) ->
    Regions = [],
    Visited = gb_sets:new(),
    find_regions_and_prepare_grid_loop(Grid, Rows, Cols, 0, 0, Regions, Visited).

find_regions_and_prepare_grid_loop(Grid, Rows, Cols, R, C, AccRegions, AccVisited) ->
    case R >= Rows of
        true -> {lists:reverse(AccRegions), AccVisited};
        false ->
            case C >= Cols of
                true -> find_regions_and_prepare_grid_loop(Grid, Rows, Cols, R + 1, 0, AccRegions, AccVisited);
                false ->
                    CellValue = get_cell(Grid, R, C),
                    case CellValue == 1 andalso not gb_sets:is_member({R, C}, AccVisited) of
                        true ->
                            {RegionCells, UninfectedNeighbors, WallsCount, NewVisited} = 
                                bfs_region(Grid, R, C, Rows, Cols, AccVisited),
                            NewAccRegions = [{RegionCells, UninfectedNeighbors, WallsCount} | AccRegions],
                            find_regions_and_prepare_grid_loop(Grid, Rows, Cols, R, C + 1, NewAccRegions, NewVisited);
                        false ->
                            find_regions_and_prepare_grid_loop(Grid, Rows, Cols, R, C + 1, AccRegions, AccVisited)
                    end
            end
    end.

finalize_spread(Grid, Rows, Cols) ->
    finalize_spread_loop(Grid, Rows, Cols, 0, 0).

finalize_spread_loop(Grid, Rows, Cols, R, C) ->
    case R >= Rows of
        true -> Grid;
        false ->
            case C >= Cols of
                true -> finalize_spread_loop(Grid, Rows, Cols, R + 1, 0);
                false ->
                    CellValue = get_cell(Grid, R, C),
                    case CellValue == 2 of
                        true ->
                            NewGrid = set_cell(Grid, R, C, 1),
                            finalize_spread_loop(NewGrid, Rows, Cols, R, C + 1);
                        false ->
                            finalize_spread_loop(Grid, Rows, Cols, R, C + 1)
                    end
            end
    end.