-module(contain_virus).
-export([containVirus/1]).

containVirus(grid) ->
    containVirus(grid, 0).

containVirus(Grid, Walls) ->
    {Regions, InfectedPerimeters, FirewallCosts} = findRegions(Grid),
    if Regions == [],
        true -> Walls;
        true ->
            {_, Index} = lists:max([ {length(Perimeter), I} || {I, Perimeter} <- lists:zip(lists:seq(1, length(InfectedPerimeters)), InfectedPerimeters)]),
            NewGrid = spreadVirus(Grid, Regions, Index),
            containVirus(NewGrid, Walls + lists:nth(Index, FirewallCosts))
    end.

findRegions(Grid) ->
    {Rows, Cols} = {length(Grid), length(hd(Grid))},
    Visited = sets:new(),
    findRegions(Grid, Rows, Cols, Visited, [], [], []).

findRegions(Grid, Rows, Cols, Visited, Regions, InfectedPerimeters, FirewallCosts) ->
    case findUnvisitedInfected(Grid, Rows, Cols, Visited) of
        false ->
            {Regions, InfectedPerimeters, FirewallCosts};
        {Row, Col} ->
            {Region, Perimeter, FirewallCost, NewVisited} = dfs(Grid, Rows, Cols, Row, Col, sets:add({Row, Col}, Visited), [], sets:new(), 0),
            findRegions(Grid, Rows, Cols, NewVisited, [Region | Regions], [Perimeter | InfectedPerimeters], [FirewallCost | FirewallCosts])
    end.

findUnvisitedInfected(Grid, Rows, Cols, Visited) ->
    lists:foldl(
        fun(Row, Acc) ->
            case Acc of
                false ->
                    lists:foldl(
                        fun(Col, Acc2) ->
                            case Acc2 of
                                false ->
                                    if lists:nth(Col, lists:nth(Row, Grid)) == 1 and not sets:is_element({Row, Col}, Visited),
                                        true -> {Row, Col};
                                        false -> false
                                    end;
                                _ -> Acc2
                            end
                        , false, lists:seq(1, Cols));
                _ -> Acc
            end
        , false, lists:seq(1, Rows)).

dfs(Grid, Rows, Cols, Row, Col, Visited, Region, Perimeter, FirewallCost) ->
    if Row < 1 or Row > Rows or Col < 1 or Col > Cols,
        true -> {Region, sets:to_list(Perimeter), FirewallCost, Visited};
        true ->
            case lists:nth(Col, lists:nth(Row, Grid)) of
                0 ->
                    if not sets:is_element({Row, Col}, Perimeter),
                        true ->
                            {NewRegion, NewPerimeter, NewFirewallCost, NewVisited} = {Region, sets:add({Row, Col}, Perimeter), FirewallCost + 1, Visited},
                            {NewRegion, sets:to_list(NewPerimeter), NewFirewallCost, NewVisited};
                        false -> {Region, sets:to_list(Perimeter), FirewallCost, Visited}
                    end;
                1 ->
                    if sets:is_element({Row, Col}, Visited),
                        true -> {Region, sets:to_list(Perimeter), FirewallCost, Visited};
                        true ->
                            NewVisited = sets:add({Row, Col}, Visited),
                            {Region1, Perimeter1, FirewallCost1, Visited1} = dfs(Grid, Rows, Cols, Row - 1, Col, NewVisited, [{Row, Col} | Region], Perimeter, FirewallCost),
                            {Region2, Perimeter2, FirewallCost2, Visited2} = dfs(Grid, Rows, Cols, Row + 1, Col, Visited1, Region1, Perimeter1, FirewallCost1),
                            {Region3, Perimeter3, FirewallCost3, Visited3} = dfs(Grid, Rows, Cols, Row, Col - 1, Visited2, Region2, Perimeter2, FirewallCost2),
                            {Region4, Perimeter4, FirewallCost4, Visited4} = dfs(Grid, Rows, Cols, Row, Col + 1, Visited3, Region3, Perimeter3, FirewallCost3),
                            {Region4, sets:to_list(Perimeter4), FirewallCost4, Visited4};
                    end;
                _ -> {Region, sets:to_list(Perimeter), FirewallCost, Visited}
            end
    end.

spreadVirus(Grid, Regions, Index) ->
    lists:foldl(
        fun(RowIndex, Acc) ->
            lists:foldl(
                fun(ColIndex, Acc2) ->
                    case lists:nth(ColIndex, lists:nth(RowIndex, Acc2)) of
                        1 -> Acc2;
                        2 -> updateCell(Acc2, RowIndex, ColIndex, 1);
                        _ -> Acc2
                    end
                , Acc, lists:seq(1, length(hd(Grid))))
        , freezeRegions(Grid, lists:nth(Index, Regions)), lists:seq(1, length(Grid))).

freezeRegions(Grid, Region) ->
    lists:foldl(
        fun({Row, Col}, Acc) ->
            updateCell(Acc, Row, Col, 2)
        , Grid, Region).

updateCell(Grid, Row, Col, Value) ->
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    lists:nth(Row, Grid) ++ [nil],
    lists:nth(Row, Grid) -- [nil],
    RowList = lists:nth(Row, Grid),
    lists:nth(Col, RowList) ++ [nil],
    lists:nth(Col, RowList) -- [nil],
    RowList2 = lists:nth(Row, Grid),
    lists:keyreplace(Col, 1, RowList2, Value),
    lists:keyreplace(Col, 1, RowList2, Value),
    lists:keyreplace(Col