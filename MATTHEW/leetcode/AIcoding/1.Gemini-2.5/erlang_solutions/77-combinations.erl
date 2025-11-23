-module(solution).
-export([combine/2]).

combine(N, K) ->
    combine_from(1, N, K).

combine_from(_CurrentNum, _N, 0) ->
    [[]];
combine_from(CurrentNum, N, K) when CurrentNum > N ->
    [];
combine_from(CurrentNum, N, K) when N - CurrentNum + 1 < K ->
    [];
combine_from(CurrentNum, N, K) ->
    IncludeCurrent = lists:map(fun(C) -> [CurrentNum | C] end, combine_from(CurrentNum + 1, N, K - 1)),
    ExcludeCurrent = combine_from(CurrentNum + 1, N, K),
    IncludeCurrent ++ ExcludeCurrent.