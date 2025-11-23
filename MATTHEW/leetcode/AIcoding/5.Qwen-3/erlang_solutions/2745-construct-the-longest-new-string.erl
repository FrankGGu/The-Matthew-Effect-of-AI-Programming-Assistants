-module(solution).
-export([longest_new_string/1]).

longest_new_string(Params) ->
    A = lists:nth(1, Params),
    B = lists:nth(2, Params),
    C = lists:nth(3, Params),
    longest_new_string(A, B, C).

longest_new_string(A, B, C) ->
    Max = max(A, max(B, C)),
    if
        A + B + C - 3 < 0 -> 0;
        true -> min(A + B + C, 2 * (Max - 1) + 1)
    end.