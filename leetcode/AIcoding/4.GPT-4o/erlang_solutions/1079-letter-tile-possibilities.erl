-module(solution).
-export([numTilePossibilities/1]).

numTilePossibilities(Tiles) ->
    TilesList = string:to_list(Tiles),
    sets:from_list(TilesList, []),
    tile_possibilities(TilesList, []).

tile_possibilities([], _) -> 0;
tile_possibilities(Tiles, Used) ->
    Distinct = lists:usort(Tiles),
    count_possibilities(Distinct, Tiles, Used, 0).

count_possibilities([], _, _, Acc) -> Acc;
count_possibilities([H | T], Tiles, Used, Acc) ->
    NewUsed = [H | Used],
    NewCount = length(NewUsed),
    NewAcc = Acc + NewCount,
    count_possibilities(T, Tiles, Used, NewAcc) + count_possibilities(T, Tiles, NewUsed, NewAcc).