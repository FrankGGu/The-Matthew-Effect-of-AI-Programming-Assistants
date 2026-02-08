-module(solution).
-export([count_highest_score/1]).

count_highest_score(Tree) ->
    Nodes = length(Tree),
    Scores = lists:map(fun(X) -> score(X, Tree, Nodes) end, lists:seq(1, Nodes)),
    MaxScore = lists:max(Scores),
    lists:foldl(fun(X, Acc) -> if X =:= MaxScore -> Acc + 1; true -> Acc end end, 0, Scores).

score(Node, Tree, Nodes) ->
    case lists:nth(Node, Tree) of
        [] -> 0;
        Children ->
            ChildCount = length(Children),
            Total = Nodes - ChildCount - 1,
            ChildScore = lists:foldl(fun(X, Acc) -> Acc * (score(X, Tree, Nodes) + 1) end, 1, Children),
            Total * ChildScore
    end.