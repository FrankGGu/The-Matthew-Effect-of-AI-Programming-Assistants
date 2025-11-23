-module(kth_largest_element).
-export([init/2, add/2]).

init(K, Nums) ->
    InitialTree = gb_trees:empty(),
    InitialCount = 0,
    {FinalTree, FinalCount} = lists:foldl(
        fun(Num, {AccTree, AccCount}) ->
            add_to_tree_internal(Num, K, AccTree, AccCount)
        end,
        {InitialTree, InitialCount},
        Nums
    ),
    {K, FinalTree, FinalCount}.

add(Val, {K, Tree, Count}) ->
    {NewTree, NewCount} = add_to_tree_internal(Val, K, Tree, Count),
    %% The Kth largest element is the smallest element in the gb_tree (min-heap root).
    %% The problem guarantees that there will be at least K elements when we search for the Kth element,
    %% meaning the tree will always contain K elements here.
    {SmallestKey, _Value} = gb_trees:smallest(NewTree),
    {SmallestKey, {K, NewTree, NewCount}}.

add_to_tree_internal(Val, K, Tree, Count) ->
    if
        Count < K ->
            %% If the tree is not yet full, just insert the value.
            NewTree = gb_trees:insert(Val, Val, Tree),
            NewCount = Count + 1,
            {NewTree, NewCount};
        Val > element(1, gb_trees:smallest(Tree)) ->
            %% If the tree is full (Count == K) and the new value is larger
            %% than the current smallest element in the tree,
            %% remove the smallest and insert the new value.
            {SmallestKey, _} = gb_trees:smallest(Tree),
            TempTree = gb_trees:delete(SmallestKey, Tree),
            NewTree = gb_trees:insert(Val, Val, TempTree),
            {NewTree, Count}; %% Count remains K
        true ->
            %% If the tree is full and the new value is not larger than the smallest element,
            %% it means the new value is not among the K largest, so do nothing.
            {Tree, Count}
    end.