-module(memory_allocator).
-export([start/1, allocate/2, free/1]).

start(N) ->
    ets:new(memory, [named_table, public, bag]),
    ets:insert(memory, {free_blocks, [{0, N}]}),
    ok.

allocate(Size, MId) ->
    case find_block(Size) of
        {Start, BlockSize} ->
            ets:delete(memory, {free_blocks, [{Start, BlockSize}]}),
            NewFreeBlocks = 
                if BlockSize > Size then
                    ets:insert(memory, {free_blocks, [{Start + Size, BlockSize - Size}]}),
                    [{Start + Size, BlockSize - Size}]
                else
                    []
                end,
            ets:insert(memory, {allocated, [{Start, Size, MId}]}),
            Start;
        false ->
            -1
    end.

free(MId) ->
    case find_allocation(MId) of
        {Start, Size, _} ->
            ets:delete(memory, {allocated, [{Start, Size, MId}]}),
            ets:insert(memory, {free_blocks, [{Start, Size}]}),
            merge_free_blocks(),
            true;
        false ->
            false
    end.

find_block(Size) ->
    case ets:tab2list(memory) of
        List ->
            FreeBlocks = lists:filter(fun({free_blocks, _}) -> true; (_) -> false end, List),
            case FreeBlocks of
                [{free_blocks, Blocks}] ->
                    find_best_block(Blocks, Size);
                _ ->
                    false
            end
    end.

find_best_block([], _Size) ->
    false.

find_best_block([{Start, BlockSize} | Rest], Size) ->
    if BlockSize >= Size then
        {Start, BlockSize}
    else
        find_best_block(Rest, Size)
    end.

find_allocation(MId) ->
    case ets:tab2list(memory) of
        List ->
            AllocatedBlocks = lists:filter(fun({allocated, _}) -> true; (_) -> false end, List),
            case AllocatedBlocks of
                [{allocated, Blocks}] ->
                    find_allocation_by_id(Blocks, MId);
                _ ->
                    false
            end
    end.

find_allocation_by_id([], _MId) ->
    false.

find_allocation_by_id([{Start, Size, MId} | Rest], MId) ->
    if MId == MId then
        {Start, Size, MId}
    else
        find_allocation_by_id(Rest, MId)
    end.

merge_free_blocks() ->
    case ets:tab2list(memory) of
        List ->
            FreeBlocks = lists:filter(fun({free_blocks, _}) -> true; (_) -> false end, List),
            case FreeBlocks of
                [{free_blocks, Blocks}] ->
                    SortedBlocks = lists:sort(Blocks, fun({A1, _}, {A2, _}) -> A1 < A2 end),
                    MergedBlocks = merge_adjacent_blocks(SortedBlocks),
                    ets:delete(memory, {free_blocks, _}),
                    ets:insert(memory, {free_blocks, MergedBlocks});
                _ ->
                    ok
            end
    end.

merge_adjacent_blocks([]) ->
    [];
merge_adjacent_blocks([Block]) ->
    [Block];
merge_adjacent_blocks([{Start1, Size1}, {Start2, Size2} | Rest]) ->
    if Start1 + Size1 == Start2 then
        merge_adjacent_blocks([{Start1, Size1 + Size2} | Rest])
    else
        [{Start1, Size1} | merge_adjacent_blocks([{Start2, Size2} | Rest])]
    end.