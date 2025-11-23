-module(solution).
-export([minimum_white_tiles/3]).

minimum_white_tiles(N, carpets, len) ->
    Tiles = lists:duplicate(N, 1),
    minimum_white_tiles_helper(Tiles, carpets, len, 0).

minimum_white_tiles_helper(Tiles, 0, _, White) ->
    White + lists:sum(Tiles);
minimum_white_tiles_helper(Tiles, Carpets, Len, White) ->
    NewWhite = White + lists:sum(Tiles),
    case lists:prefix(Tiles, lists:duplicate(len, 1)) of
        true ->
            minimum_white_tiles_helper(Tiles, Carpets - 1, Len, 0);
        false ->
            minimum_white_tiles_helper(Tiles, Carpets, Len, NewWhite)
    end.