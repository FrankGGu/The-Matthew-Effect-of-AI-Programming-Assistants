-module(solution).
-export([rearrange_array/1]).

rearrange_array(Array) ->
    Positives = [X || X <- Array, X > 0],
    Negatives = [X || X <- Array, X < 0],
    rearrange(Positives, Negatives, []).

rearrange([], [], Acc) -> lists:reverse(Acc);
rearrange([H1 | T1], [H2 | T2], Acc) ->
    rearrange(T1, T2, [H1, H2 | Acc]).