-module(solution).
-export([areColorsSame/2]).

areColorsSame(Square1, Square2) ->
    Parity1 = get_color_parity(Square1),
    Parity2 = get_color_parity(Square2),
    Parity1 == Parity2.

get_color_parity([ColChar, RowChar]) ->
    ColIndex = ColChar - $a + 1,
    RowIndex = RowChar - $0,
    (ColIndex + RowIndex) rem 2.