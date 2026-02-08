-module(chessboard_square_color).
-export([square_is_white/1]).

square_is_white(S) ->
    [C, D] = S,
    CCode = C - $a,
    DCode = D - $1,
    (CCode + DCode) rem 2 == 1.