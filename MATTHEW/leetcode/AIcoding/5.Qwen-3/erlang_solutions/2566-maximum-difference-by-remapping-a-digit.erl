-module(maximum_difference_by_remapping_a_digit).
-export([maxDiff/1]).

maxDiff(N) ->
    S = integer_to_list(N),
    Max = lists:max([lists:foldl(fun(D, Acc) -> Acc * 10 + (if D == C -> R; true -> D end) end, 0, S) || C <- S, R <- lists:seq(0,9), R =/= C]),
    Min = lists:min([lists:foldl(fun(D, Acc) -> Acc * 10 + (if D == C -> R; true -> D end) end, 0, S) || C <- S, R <- lists:seq(0,9), R =/= C]),
    Max - Min.