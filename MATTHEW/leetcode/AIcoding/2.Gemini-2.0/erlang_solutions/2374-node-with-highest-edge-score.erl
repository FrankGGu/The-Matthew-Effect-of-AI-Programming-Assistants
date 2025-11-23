-module(highest_edge_score).
-export([highest_edge_score/1]).

highest_edge_score(Edges) ->
    N = length(Edges),
    Scores = lists:map(fun(_) -> 0 end, lists:seq(1, N)),
    UpdatedScores = lists:foldl(
        fun({Index, Value}, Acc) ->
            lists:nth(Value + 1, Acc) + Index - 1
        end,
        Scores,
        lists:zip(lists:seq(1, N), Edges)
    ),
    MaxScore = lists:max(UpdatedScores),
    FirstIndex = lists:keyfind(MaxScore, 1, lists:zip(UpdatedScores, lists:seq(0, N - 1))),
    case FirstIndex of
        false ->
            -1;
        {MaxScore, Index} ->
            Index
    end.