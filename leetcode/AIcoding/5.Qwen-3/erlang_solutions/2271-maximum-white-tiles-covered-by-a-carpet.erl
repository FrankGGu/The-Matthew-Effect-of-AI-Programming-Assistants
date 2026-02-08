-module(max_white_tiles_covered_by_a_carpet).
-export([maximumWhiteTiles/2]).

maximumWhiteTiles(Tiles, CarpetLen) ->
    TilesSorted = lists:sort(Tiles),
    N = length(TilesSorted),
    Max = 0,
    {_, Result} = lists:foldl(fun({Start, End}, {Pos, Acc}) ->
        if
            Pos + CarpetLen >= End ->
                NewAcc = Acc + (End - Start),
                {End, NewAcc};
            true ->
                Covered = max(0, Pos + CarpetLen - Start),
                NewAcc = Acc + Covered,
                {Pos + CarpetLen, NewAcc}
        end
    end, {0, 0}, TilesSorted),
    Result.