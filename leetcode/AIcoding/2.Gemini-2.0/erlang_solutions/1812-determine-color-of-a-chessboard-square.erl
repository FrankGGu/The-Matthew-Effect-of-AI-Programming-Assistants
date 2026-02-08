-module(chessboard_color).
-export([square_is_white/1]).

square_is_white(Coordinates) ->
    [File, Rank] = string:to_list(Coordinates),
    FileVal = File - $a + 1,
    RankVal = Rank - $1 + 1,
    (FileVal + RankVal) rem 2 == 1.