-module(solution).
-export([squareIsWhite/1]).

squareIsWhite(Square) ->
    [ColChar, RowChar] = Square,
    ColIndex = ColChar - $a + 1,
    RowIndex = RowChar - $0,
    (ColIndex + RowIndex) rem 2 == 0.