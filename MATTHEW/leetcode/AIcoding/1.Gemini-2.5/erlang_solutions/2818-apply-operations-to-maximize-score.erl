-module(solution).
-export([max_score/2]).

max_score(Nums, K) ->
    Tree0 = lists:foldl(
        fun(Num, AccTree) ->
            Count = gb_trees:get(Num, AccTree, 0),
            gb_trees:insert(Num, Count + 1, AccTree)
        end,
        gb_trees:empty(),
        Nums
    ),
    apply_operations(K, Tree0, 0).

apply_operations(0, _Tree, Score) ->
    Score;
apply_operations(K, Tree, CurrentScore) ->
    {MaxNum, Count} = gb_trees:largest(Tree),
    NewScore = CurrentScore + MaxNum,
    Tree1 = if Count > 1 ->
                gb_trees:insert(MaxNum, Count - 1, Tree);
            true ->
                gb_trees:delete(MaxNum, Tree)
            end,
    NewNum = MaxNum div 3,
    NewNumCount = gb_trees:get(NewNum, Tree1, 0),
    Tree2 = gb_trees:insert(NewNum, NewNumCount + 1, Tree1),
    apply_operations(K - 1, Tree2, NewScore).