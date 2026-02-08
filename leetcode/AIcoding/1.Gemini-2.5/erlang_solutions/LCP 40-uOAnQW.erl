-module(solution).
-export([max_total_damage/2]).

max_total_damage(Nums, K) ->
    InitialTree = lists:foldl(fun(Num, AccTree) ->
                                  gb_trees:update(Num, fun(Count) -> Count + 1 end, 1, AccTree)
                              end, gb_trees:empty(), Nums),
    perform_selections(K, InitialTree, 0).

perform_selections(0, _Tree, CurrentSum) ->
    CurrentSum;
perform_selections(K, Tree, CurrentSum) ->
    {{MaxVal, Count}, TreeAfterTake} = gb_trees:take_largest(Tree),
    NewSum = CurrentSum + MaxVal,
    TreeAfterRemoval =
        if
            Count > 1 ->
                gb_trees:insert(MaxVal, Count - 1, TreeAfterTake);
            true ->
                TreeAfterTake
        end,
    NewVal = (MaxVal + 1) div 2,
    UpdatedTree = gb_trees:update(NewVal, fun(C) -> C + 1 end, 1, TreeAfterRemoval),
    perform_selections(K - 1, UpdatedTree, NewSum).