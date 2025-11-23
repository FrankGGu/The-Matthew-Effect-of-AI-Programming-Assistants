-module(allocator).
-export([init/1, allocate/3, free/2, find/2]).

-record(state, {n :: integer(),
                free_blocks :: gb_trees:tree(),
                allocated_blocks :: map()}).

init(N) ->
    #state{n = N,
           free_blocks = gb_trees:insert(0, N, gb_trees:empty()),
           allocated_blocks = #{}}.

allocate(Size, MID, State = #state{free_blocks = FreeBlocksTree, allocated_blocks = AllocatedBlocksMap}) ->
    case find_suitable_free_block(gb_trees:iterator(FreeBlocksTree), Size) of
        {FStart, FSize} ->
            NewFreeBlocksTree1 = gb_trees:delete(FStart, FreeBlocksTree),
            RemainingSize = FSize - Size,
            NewFreeBlocksTree = if RemainingSize > 0 -> gb_trees:insert(FStart + Size, RemainingSize, NewFreeBlocksTree1);
                                   true -> NewFreeBlocksTree1
                                end,
            NewAllocatedBlocksMap = maps:put(FStart, {Size, MID}, AllocatedBlocksMap),
            {FStart, State#state{free_blocks = NewFreeBlocksTree, allocated_blocks = NewAllocatedBlocksMap}};
        none ->
            {-1, State}
    end.

free(Idx, State = #state{allocated_blocks = AllocatedBlocksMap, free_blocks = FreeBlocksTree}) ->
    case maps:find(Idx, AllocatedBlocksMap) of
        {ok, {BlockSize, MID}} ->
            NewAllocatedBlocksMap = maps:remove(Idx, AllocatedBlocksMap),
            NewFreeBlocksTree = merge_free_blocks(Idx, BlockSize, FreeBlocksTree),
            {MID, State#state{free_blocks = NewFreeBlocksTree, allocated_blocks = NewAllocatedBlocksMap}};
        error ->
            {-1, State}
    end.

find(MID, State = #state{allocated_blocks = AllocatedBlocksMap}) ->
    FoundIndices = maps:fold(fun(StartIdx, {_, BlockMID}, Acc) ->
                                 if BlockMID == MID -> [StartIdx | Acc];
                                    true -> Acc
                                 end
                             end, [], AllocatedBlocksMap),
    lists:sort(FoundIndices).

find_suitable_free_block(Iter, Size) ->
    case gb_trees:next(Iter) of
        {K, V, NextIter} when V >= Size -> {K, V};
        {_, _, NextIter} -> find_suitable_free_block(NextIter, Size);
        none -> none
    end.

merge_free_blocks(Idx, BlockSize, FreeBlocksTree) ->
    TempTree = gb_trees:insert(Idx, BlockSize, FreeBlocksTree),

    {NewIdx1, NewSize1, TreeAfterPrevMerge} = case gb_trees:lookup_le(Idx - 1, TempTree) of
        {value, PrevStart, PrevSize} when PrevStart + PrevSize == Idx ->
            {PrevStart, PrevSize + BlockSize, gb_trees:delete(PrevStart, gb_trees:delete(Idx, TempTree))};
        _ ->
            {Idx, BlockSize, TempTree}
    end,

    {FinalIdx, FinalSize, FinalTree} = case gb_trees:lookup(NewIdx1 + NewSize1, TreeAfterPrevMerge) of
        {value, NextSize} ->
            {NewIdx1, NewSize1 + NextSize, gb_trees:delete(NewIdx1 + NewSize1, gb_trees:delete(NewIdx1, TreeAfterPrevMerge))};
        _ ->
            {NewIdx1, NewSize1, TreeAfterPrevMerge}
    end,
    gb_trees:insert(FinalIdx, FinalSize, FinalTree).