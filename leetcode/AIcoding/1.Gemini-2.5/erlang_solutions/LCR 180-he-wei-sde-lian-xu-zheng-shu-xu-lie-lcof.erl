-module(solution).
-export([min_cost/1]).

min_cost(Files) ->
    {InitialTree, InitialUniqueId} = lists:foldl(
        fun(File, {AccTree, AccId}) ->
            {gb_trees:insert({File, AccId}, true, AccTree), AccId + 1}
        end,
        {gb_trees:empty(), 0},
        Files
    ),

    merge_files(InitialTree, InitialUniqueId, 0, length(Files)).

merge_files(Tree, UniqueId, CurrentCost, NumFiles) when NumFiles =< 1 ->
    CurrentCost;
merge_files(Tree, UniqueId, CurrentCost, NumFiles) ->
    {{A, _}, Tree1} = extract_min(Tree),
    {{B, _}, Tree2} = extract_min(Tree1),

    Sum = A + B,
    NewCost = CurrentCost + Sum,

    NewTree = gb_trees:insert({Sum, UniqueId}, true, Tree2),
    NewUniqueId = UniqueId + 1,

    merge_files(NewTree, NewUniqueId, NewCost, NumFiles - 1).

extract_min(Tree) ->
    {MinKey, _} = gb_trees:smallest(Tree),
    {MinKey, gb_trees:delete(MinKey, Tree)}.