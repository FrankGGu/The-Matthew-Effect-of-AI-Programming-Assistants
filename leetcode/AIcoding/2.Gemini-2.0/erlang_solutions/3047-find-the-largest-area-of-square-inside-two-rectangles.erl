-module(largest_square_area).
-export([largest_square_area/1]).

largest_square_area([R1, R2]) ->
    {X11, Y11, X12, Y12} = R1,
    {X21, Y21, X22, Y22} = R2,

    Left := max(X11, X21),
    Right := min(X12, X22),
    Bottom := max(Y11, Y21),
    Top := min(Y12, Y22),

    Side := max(0, min(Right - Left, Top - Bottom)),
    Side * Side.