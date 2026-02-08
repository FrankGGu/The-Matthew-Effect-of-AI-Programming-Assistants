-module(solutions).
-export([abs_diffs/1]).

abs_diffs(A) ->
    N = length(A),
    Lists = lists:seq(0, N-1),
    lists:map(fun(I) -> abs_diffs_at_i(A, I, N) end, Lists).

abs_diffs_at_i(A, I, N) ->
    LeftSum = lists:sum(lists:sublist(A, 1, I)) - I * element(I+1, A),
    RightSum = (lists:sum(lists:sublist(A, I+2, N - I - 1))) - (N - I - 1) * element(I+1, A),
    LeftSum + RightSum.