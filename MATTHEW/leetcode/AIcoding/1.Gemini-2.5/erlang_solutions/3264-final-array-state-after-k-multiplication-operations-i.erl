-module(solution).
-export([final_array_state/2]).

final_array_state(Nums, K) ->
    case Nums of
        [] -> [];
        _ ->
            InitialTree = lists:foldl(
                fun({Val, Id}, Acc) -> gb_trees:insert({Val, Id}, void, Acc) end,
                gb_trees:empty(),
                lists:zip(Nums, lists:seq(1, length(Nums)))
            ),

            FinalTree = perform_operations_multiset(InitialTree, K, length(Nums) + 1),

            lists:sort([Val || {{Val, _Id}, _Void} <- gb_trees:to_list(FinalTree)])
    end.

perform_operations_multiset(Tree, 0, _NextId) ->
    Tree;
perform_operations_multiset(Tree, K, NextId) ->
    {{MaxVal, _MaxId}, _Void, TreeWithoutMax} = gb_trees:take_max(Tree),

    NewTree = gb_trees:insert({MaxVal * 2, NextId}, void, TreeWithoutMax),

    perform_operations_multiset(NewTree, K - 1, NextId + 1).