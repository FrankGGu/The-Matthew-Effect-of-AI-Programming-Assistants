-module(solution).
-export([max_score/2]).

max_score(Tree, Operations) ->
    {Max, _} = max_score_helper(Tree, Operations, 0, []),
    Max.

max_score_helper(Tree, [], Score, _) -> {Score, []};
max_score_helper(Tree, [Op | Rest], Score, Visited) ->
    NewScore = Score + Op,
    {NewMax, _} = max_score_helper(Tree, Rest, NewScore, [Op | Visited]),
    {max(Score, NewMax), Visited}.