-module(solution).
-export([merge_bsts/1]).

-record('TreeNode', {val, left = null, right = null}).

merge_bsts(Trees) ->
    RootMap = maps:new(),
    LeafNodesSet = sets:new(),
    AllNodeValuesSet = sets:new(),
    TotalNodeCount = 0,

    % First pass: Populate RootMap and collect all node values, leaf node values, and total node count
    {RootMap1, LeafNodesSet1, AllNodeValuesSet1, TotalNodeCount1} = lists:foldl(
        fun(TreeRoot, {RM, LNS, ANVS, TNC}) ->
            RM1 = maps:put(TreeRoot# 'TreeNode'.val, TreeRoot, RM),
            {CurrentTreeLeaves, CurrentTreeAllValues, CurrentTreeNodeCount} = collect_single_tree_info(TreeRoot),
            {RM1, sets:union(LNS, CurrentTreeLeaves), sets:union(ANVS, CurrentTreeAllValues), TNC + CurrentTreeNodeCount}
        end,
        {RootMap, LeafNodesSet, AllNodeValuesSet, TotalNodeCount},
        Trees
    ),

    % Find the root of the merged tree
    % It must be one of the input tree roots whose value is NOT in LeafNodesSet1
    RootCandidates = lists:filter(
        fun(RootVal) -> not sets:is_element(RootVal, LeafNodesSet1) end,
        maps:keys(RootMap1)
    ),

    case RootCandidates of
        [FinalRootVal] ->
            FinalRootTree = maps:get(FinalRootVal, RootMap1),

            % Perform the merge
            % `AvailableRootMap` starts with all input trees, `FinalRootVal` will be removed from it.
            % `UsedTreeRoots` tracks the root values of trees that have been successfully attached.
            InitialUsedTreeRoots = sets:new(),

            {MergedTree, FinalAvailableRootMap, FinalUsedTreeRoots} = 
                merge_recursive(FinalRootTree, RootMap1, LeafNodesSet1, FinalRootVal, InitialUsedTreeRoots),

            % Final validation
            % 1. All trees (except the final root tree) must have been used.
            %    This means the size of `FinalUsedTreeRoots` should be `length(Trees) - 1`.
            ExpectedUsedCount = length(Trees) - 1,
            ActualUsedCount = sets:size(FinalUsedTreeRoots),

            % 2. The `FinalAvailableRootMap` should only contain the root of the merged tree.
            %    Its size should be 1, and the key should be FinalRootVal.
            IsFinalRootMapCorrect = (maps:size(FinalAvailableRootMap) == 1) and (maps:is_key(FinalRootVal, FinalAvailableRootMap)),

            if ActualUsedCount /= ExpectedUsedCount or not IsFinalRootMapCorrect ->
                null;
            true ->
                % 3. Validate BST property and node count of the merged tree.
                {IsValidBST, MergedNodeValues, MergedNodeCount} = validate_bst(MergedTree),
                if IsValidBST and MergedNodeCount == TotalNodeCount1 and sets:is_subset(AllNodeValuesSet1, MergedNodeValues) ->
                    MergedTree;
                true ->
                    null
                end
            end;
        _ ->
            null % More than one or no root candidate
    end.

collect_single_tree_info(null) -> {sets:new(), sets:new(), 0};
collect_single_tree_info(Node) ->
    Val = Node# 'TreeNode'.val,
    {LeftLeaves, LeftAllValues, LeftCount} = collect_single_tree_info(Node# 'TreeNode'.left),
    {RightLeaves, RightAllValues, RightCount} = collect_single_tree_info(Node# 'TreeNode'.right),

    CurrentLeaves = if Node# 'TreeNode'.left == null and Node# 'TreeNode'.right == null ->
                        sets:add_element(Val, sets:union(LeftLeaves, RightLeaves));
                    true ->
                        sets:union(LeftLeaves, RightLeaves)
                    end,
    CurrentAllValues = sets:add_element(Val, sets:union(LeftAllValues, RightAllValues)),
    CurrentCount = LeftCount + RightCount + 1,
    {CurrentLeaves, CurrentAllValues, CurrentCount}.

merge_recursive(null, AvailableRootMap, _LeafNodesSet, _FinalRootVal, UsedTreeRoots) -> 
    {null, AvailableRootMap, UsedTreeRoots};
merge_recursive(Node, AvailableRootMap, LeafNodesSet, FinalRootVal, UsedTreeRoots) ->
    Val = Node# 'TreeNode'.val,

    % If this node is a leaf in its current context, and its value matches a root of another available tree,
    % and this node's value is in the set of original leaf values (meaning it's a candidate for replacement),
    % and it's not the root of the final merged tree itself (to avoid self-replacement of the main root).
    if Node# 'TreeNode'.left == null and Node# 'TreeNode'.right == null and
       sets:is_element(Val, LeafNodesSet) and
       maps:is_key(Val, AvailableRootMap) and
       Val /= FinalRootVal ->

        SubTreeRoot = maps:get(Val, AvailableRootMap),
        AvailableRootMap1 = maps:remove(Val, AvailableRootMap), % Remove the used tree from available map
        UsedTreeRoots1 = sets:add_element(Val, UsedTreeRoots), % Mark this subtree's root as used

        % Recursively merge the subtree. The `SubTreeRoot` itself might have leaves that need replacement.
        merge_recursive(SubTreeRoot, AvailableRootMap1, LeafNodesSet, FinalRootVal, UsedTreeRoots1);
    true ->
        % It's an internal node, or a true leaf that doesn't need replacement, or the final root.
        % Recursively process children.
        {NewLeft, AvailableRootMap1, UsedTreeRoots1} = 
            merge_recursive(Node# 'TreeNode'.left, AvailableRootMap, LeafNodesSet, FinalRootVal, UsedTreeRoots),
        {NewRight, AvailableRootMap2, UsedTreeRoots2} = 
            merge_recursive(Node# 'TreeNode'.right, AvailableRootMap1, LeafNodesSet, FinalRootVal, UsedTreeRoots1),

        {Node# 'TreeNode'{left = NewLeft, right = NewRight}, AvailableRootMap2, UsedTreeRoots2}
    end.

validate_bst(Tree) ->
    inorder_validate(Tree, -infinity, infinity).

inorder_validate(null, _Min, _Max) -> {true, sets:new(), 0};
inorder_validate(Node, Min, Max) ->
    Val = Node# 'TreeNode'.val,
    if Val =< Min or Val >= Max ->
        {false, sets:new(), 0}; % Not a BST
    true ->
        {LeftValid, LeftValues, LeftCount} = inorder_validate(Node# 'TreeNode'.left, Min, Val),
        if not LeftValid ->
            {false, sets:new(), 0};
        true ->
            {RightValid, RightValues, RightCount} = inorder_validate(Node# 'TreeNode'.right, Val, Max),
            if not RightValid ->
                {false, sets:new(), 0};
            true ->
                CombinedValues = sets:add_element(Val, sets:union(LeftValues, RightValues)),
                CombinedCount = LeftCount + 1 + RightCount,
                {true, CombinedValues, CombinedCount}
            end
        end
    end.