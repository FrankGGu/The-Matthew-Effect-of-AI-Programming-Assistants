-module(solution).
-export([rearrange_array/1]).

rearrange_array(Nums) ->
    Positives = [X || X <- Nums, X > 0],
    Negatives = [X || X <- Nums, X < 0],
    merge_alternating(Positives, Negatives).

merge_alternating([P|Ps], [N|Ns]) ->
    [P, N | merge_alternating(Ps, Ns)];
merge_alternating([], []) ->
    [].