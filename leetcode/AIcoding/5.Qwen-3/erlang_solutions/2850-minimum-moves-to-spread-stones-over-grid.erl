-module(minimum_moves_to_spread_stones_over_grid).
-export([minMovesToSpreadStones/1]).

minMovesToSpreadStones(Grid) ->
    Stones = collect_stones(Grid),
    Cells = collect_cells(Grid),
    solve(Stones, Cells).

collect_stones(Grid) ->
    collect_stones(Grid, []).

collect_stones([], Acc) ->
    Acc;
collect_stones([Row | Rest], Acc) ->
    collect_stones(Rest, lists:foldl(fun({X, Y}, AccIn) -> [{X, Y} | AccIn] end, Acc, stones_in_row(Row))).

stones_in_row([]) ->
    [];
stones_in_row([0 | Rest]) ->
    stones_in_row(Rest);
stones_in_row([N | Rest]) ->
    [ {0, 0} || _ <- lists:seq(1, N) ] ++ stones_in_row(Rest).

collect_cells(Grid) ->
    collect_cells(Grid, []).

collect_cells([], Acc) ->
    Acc;
collect_cells([Row | Rest], Acc) ->
    collect_cells(Rest, lists:foldl(fun({X, Y}, AccIn) -> [{X, Y} | AccIn] end, Acc, cells_in_row(Row))).

cells_in_row([]) ->
    [];
cells_in_row([_ | Rest]) ->
    [ {0, 0} || _ <- lists:seq(1, length(Row)) ] ++ cells_in_row(Rest).

solve(Stones, Cells) ->
    solve(Stones, Cells, 0).

solve([], _, Acc) ->
    Acc;
solve([S | RestS], Cells, Acc) ->
    {X, Y} = S,
    {MinDist, NewCells} = find_min_dist(S, Cells),
    solve(RestS, NewCells, Acc + MinDist).

find_min_dist({SX, SY}, Cells) ->
    find_min_dist({SX, SY}, Cells, 1e9, []).

find_min_dist(_, [], MinDist, BestCells) ->
    {MinDist, BestCells};
find_min_dist({SX, SY}, [{CX, CY} | Rest], MinDist, BestCells) ->
    Dist = abs(SX - CX) + abs(SY - CY),
    if
        Dist < MinDist ->
            find_min_dist({SX, SY}, Rest, Dist, [{CX, CY} | BestCells]);
        true ->
            find_min_dist({SX, SY}, Rest, MinDist, BestCells)
    end.