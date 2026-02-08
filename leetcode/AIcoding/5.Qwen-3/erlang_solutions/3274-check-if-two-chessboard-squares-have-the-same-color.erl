-module(solution).
-export([is_same_color/2]).

is_same_color(S1, S2) ->
    [R1, C1] = S1,
    [R2, C2] = S2,
    (R1 + C1) rem 2 == (R2 + C2) rem 2.