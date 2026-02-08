-module(solution).
-export([make_square_with_same_color/1]).

-spec make_square_with_same_color(Grid :: list(list(char()))) -> boolean().
make_square_with_same_color(Grid) ->
    [R0, R1, R2] = Grid,
    [C00, C01, C02] = R0,
    [C10, C11, C12] = R1,
    [C20, C21, C22] = R2,

    (C00 == C01 andalso C00 == C10 andalso C00 == C11) orelse
    (C01 == C02 andalso C01 == C11 andalso C01 == C12) orelse
    (C10 == C11 andalso C10 == C20 andalso C10 == C21) orelse
    (C11 == C12 andalso C11 == C21 andalso C11 == C22).