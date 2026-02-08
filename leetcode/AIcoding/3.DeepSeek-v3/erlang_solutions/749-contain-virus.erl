-spec contain_virus(IsInfected :: [[integer()]]) -> integer().
contain_virus(IsInfected) ->
    Grid = [list_to_tuple(Row) || Row <- IsInfected],
    Rows = length(IsInfected),
    Cols = length(hd(IsInfected)),
    Walls = 0,
    {Result, _} = simulate(Grid, Rows, Cols, Walls),
    Result.

simulate(Grid, Rows, Cols, Walls) ->
    case find_regions(Grid, Rows, Cols) of
        [] -> {Walls, Grid};
        Regions ->
            {MaxRegion, MaxThreat} = find_most_threatening(Regions),
            NewWalls = Walls + build_walls(MaxRegion, Grid, Rows, Cols),
            NewGrid = spread_virus(lists:delete(MaxRegion, Regions), Grid, Rows, Cols),
            simulate(NewGrid, Rows, Cols, NewWalls)
    end.

find_regions(Grid, Rows, Cols) ->
    Visited = sets:new(),
    Regions = [],
    find_regions(0, 0, Rows, Cols, Grid, Visited, Regions).

find_regions(R, C, Rows, Cols, Grid, Visited, Regions) when R >= Rows ->
    Regions;
find_regions(R, C, Rows, Cols, Grid, Visited, Regions) when C >= Cols ->
    find_regions(R + 1, 0, Rows, Cols, Grid, Visited, Regions);
find_regions(R, C, Rows, Cols, Grid, Visited, Regions) ->
    case element(C + 1, element(R + 1, Grid)) of
        1 ->
            case sets:is_element({R, C}, Visited) of
                true ->
                    find_regions(R, C + 1, Rows, Cols, Grid, Visited, Regions);
                false ->
                    {Region, NewVisited} = flood_fill(R, C, Rows, Cols, Grid, Visited, []),
                    Threat = calculate_threat(Region, Grid, Rows, Cols),
                    find_regions(R, C + 1, Rows, Cols, Grid, NewVisited, [{Region, Threat} | Regions])
            end;
        _ ->
            find_regions(R, C + 1, Rows, Cols, Grid, Visited, Regions)
    end.

flood_fill(R, C, Rows, Cols, Grid, Visited, Region) ->
    case R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols of
        true ->
            case element(C + 1, element(R + 1, Grid)) of
                1 ->
                    case sets:is_element({R, C}, Visited) of
                        true ->
                            {Region, Visited};
                        false ->
                            NewVisited = sets:add_element({R, C}, Visited),
                            NewRegion = [{R, C} | Region],
                            {Region1, Visited1} = flood_fill(R - 1, C, Rows, Cols, Grid, NewVisited, NewRegion),
                            {Region2, Visited2} = flood_fill(R + 1, C, Rows, Cols, Grid, Visited1, Region1),
                            {Region3, Visited3} = flood_fill(R, C - 1, Rows, Cols, Grid, Visited2, Region2),
                            {Region4, Visited4} = flood_fill(R, C + 1, Rows, Cols, Grid, Visited3, Region3),
                            {Region4, Visited4}
                    end;
                _ ->
                    {Region, Visited}
            end;
        false ->
            {Region, Visited}
    end.

calculate_threat(Region, Grid, Rows, Cols) ->
    Threat = sets:new(),
    lists:foldl(
        fun({R, C}, Acc) ->
            lists:foldl(
                fun({Dr, Dc}, AccIn) ->
                    NR = R + Dr,
                    NC = C + Dc,
                    case NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols of
                        true ->
                            case element(NC + 1, element(NR + 1, Grid)) of
                                0 -> sets:add_element({NR, NC}, AccIn);
                                _ -> AccIn
                            end;
                        false -> AccIn
                    end
                end,
                Acc,
                [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
            )
        end,
        Threat,
        Region
    ),
    sets:size(Threat).

find_most_threatening(Regions) ->
    lists:foldl(
        fun({Region, Threat}, {MaxRegion, MaxThreat}) ->
            if Threat > MaxThreat -> {Region, Threat};
               true -> {MaxRegion, MaxThreat}
            end
        end,
        {[], -1},
        Regions
    ).

build_walls(Region, Grid, Rows, Cols) ->
    Walls = 0,
    lists:foldl(
        fun({R, C}, Acc) ->
            lists:foldl(
                fun({Dr, Dc}, AccIn) ->
                    NR = R + Dr,
                    NC = C + Dc,
                    case NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols of
                        true ->
                            case element(NC + 1, element(NR + 1, Grid)) of
                                0 -> AccIn + 1;
                                _ -> AccIn
                            end;
                        false -> AccIn
                    end
                end,
                Acc,
                [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
            )
        end,
        Walls,
        Region
    ).

spread_virus(Regions, Grid, Rows, Cols) ->
    NewGrid = [tuple_to_list(Row) || Row <- tuple_to_list(Grid)],
    Infected = sets:new(),
    lists:foreach(
        fun({Region, _}) ->
            lists:foreach(
                fun({R, C}) ->
                    lists:foreach(
                        fun({Dr, Dc}) ->
                            NR = R + Dr,
                            NC = C + Dc,
                            case NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols of
                                true ->
                                    case lists:nth(NC + 1, lists:nth(NR + 1, NewGrid)) of
                                        0 -> sets:add_element({NR, NC}, Infected);
                                        _ -> ok
                                    end;
                                false -> ok
                            end
                        end,
                        [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
                    )
                end,
                Region
            )
        end,
        Regions
    ),
    UpdatedGrid = lists:map(
        fun(R) ->
            lists:map(
                fun(C) ->
                    case sets:is_element({R - 1, C - 1}, Infected) of
                        true -> 1;
                        false -> lists:nth(C, lists:nth(R, NewGrid))
                    end
                end,
                lists:seq(1, Cols)
            )
        end,
        lists:seq(1, Rows)
    ),
    list_to_tuple([list_to_tuple(Row) || Row <- UpdatedGrid]).