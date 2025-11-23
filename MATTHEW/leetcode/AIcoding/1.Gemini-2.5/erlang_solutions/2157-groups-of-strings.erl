-module(solution).
-export([groups_of_strings/1]).

mask(String) ->
    lists:foldl(fun(C, Acc) ->
        Acc bor (1 bsl (C - $a))
    end, 0, String).

find(Mask, ParentTree) ->
    case gb_trees:lookup(Mask, ParentTree) of
        {value, Mask} -> {Mask, ParentTree}; % Mask is its own parent, return it and unchanged tree
        {value, ParentMask} ->
            {Root, P_Updated} = find(ParentMask, ParentTree), % Recurse on parent
            {Root, gb_trees:update(Mask, Root, P_Updated)} % Path compress: point Mask directly to Root
    end.

union(Mask1, Mask2, ParentTree, SizeTree) ->
    {Root1, P1_Updated} = find(Mask1, ParentTree),
    {Root2, P2_Updated} = find(Mask2, P1_Updated), % Use potentially updated tree from first find

    if
        Root1 == Root2 -> {P2_Updated, SizeTree}; % Already in same group
        true ->
            Size1 = gb_trees:get(Root1, SizeTree),
            Size2 = gb_trees:get(Root2, SizeTree),

            %% Merge Root2 into Root1 (arbitrary choice, could be by size/rank)
            NewParent = gb_trees:update(Root2, Root1, P2_Updated),
            NewSize = gb_trees:update(Root1, Size1 + Size2, SizeTree),
            {NewParent, NewSize}
    end.

groups_of_strings(Words) ->
    %% 1. Calculate masks and initial counts for each unique mask
    MasksWithCounts = lists:foldl(fun(Word, Acc) ->
        M = mask(Word),
        gb_trees:enter(M, gb_trees:get(M, Acc, 0) + 1, Acc)
    end, gb_trees:empty(), Words),

    UniqueMasks = gb_trees:keys(MasksWithCounts),

    %% 2. Initialize DSU Parent and Size maps
    %% Each unique mask is initially its own parent.
    InitialParent = lists:foldl(fun(M, Acc) ->
        gb_trees:enter(M, M, Acc)
    end, gb_trees:empty(), UniqueMasks),

    %% Initial size of each component is the count of words that map to that mask.
    InitialSize = MasksWithCounts,

    %% 3. Perform unions based on connections
    %% Iterate through each unique mask M1. For each M1, check all 26 possible
    %% masks M_Flipped that differ by exactly one bit. If M_Flipped exists, union M1 and M_Flipped.
    {FinalParent, FinalSize} = lists:foldl(fun(M1, {CurrentParent, CurrentSize}) ->
        lists:foldl(fun(I, {P, S}) ->
            M_Flipped = M1 bxor (1 bsl I),
            case gb_trees:is_defined(M_Flipped, MasksWithCounts) of
                true -> union(M1, M_Flipped, P, S);
                false -> {P, S}
            end
        end, {CurrentParent, CurrentSize}, lists:seq(0, 25))
    end, {InitialParent, InitialSize}, UniqueMasks),

    %% 4. Calculate num_groups and max_group_size
    %% After all unions, FinalParent contains the consolidated parent pointers.
    %% We need to iterate through all unique masks again to find their ultimate roots
    %% and aggregate their original counts to get the total size of each group.

    ActualGroupSizes = lists:foldl(fun(M, Acc) ->
        {Root, _} = find(M, FinalParent), % Find the ultimate root for M, implicitly compressing paths
        CurrentSize = gb_trees:get(M, MasksWithCounts), % Get original count for this mask
        gb_trees:enter(Root, gb_trees:get(Root, Acc, 0) + CurrentSize, Acc)
    end, gb_trees:empty(), UniqueMasks),

    NumGroups = gb_trees:size(ActualGroupSizes),

    MaxGroupSize = case gb_trees:values(ActualGroupSizes) of
        [] -> 0;
        Sizes -> lists:max(Sizes)
    end,

    [NumGroups, MaxGroupSize].