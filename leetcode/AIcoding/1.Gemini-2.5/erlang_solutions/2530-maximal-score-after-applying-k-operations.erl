-module(solution).
-export([max_score/2]).

max_score(Nums, K) ->
    InitialTree = lists:foldl(fun(Num, AccTree) ->
                                  gb_trees:insert(Num, true, AccTree)
                              end, gb_trees:empty(), Nums),
    perform_operations(K, InitialTree, 0).

perform_operations(0, _Tree, Score) ->
    Score;
perform_operations(K, Tree, CurrentScore) ->
    {MaxNum, _, TreeWithoutMax} = gb_trees:take_max(Tree),
    NewScore = CurrentScore + MaxNum,
    NewNum = (MaxNum + 2) div 3,
    UpdatedTree = gb_trees:insert(NewNum, true, TreeWithoutMax),
    perform_operations(K - 1, UpdatedTree, NewScore).