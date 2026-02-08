-module(solution).
-export([best_rotation/1]).

best_rotation(A) ->
    N = length(A),
    ScoreList = lists:foldl(fun(Index, Acc) ->
        [Acc + (N - Index) - lists:sum(lists:sublist(A, Index + 1, N - Index)) | Acc]
    end, [], lists:seq(0, N - 1)),
    lists:max(ScoreList) - lists:seq(0, N - 1) ++ [lists:index(lists:max(ScoreList), ScoreList)].