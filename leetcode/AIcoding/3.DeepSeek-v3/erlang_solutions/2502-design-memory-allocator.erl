-module(memory_allocator).
-export([init/1, allocate/3, free/2]).

init(N) ->
    {N, []}.

allocate(Pid, Size, MId) ->
    {Total, Allocated} = Pid,
    case find_free_block(Allocated, Size) of
        {Start, NewAllocated} ->
            {Start, {Total, [{MId, Start, Size} | NewAllocated]}};
        error ->
            {-1, Pid}
    end.

free(Pid, MId) ->
    {Total, Allocated} = Pid,
    NewAllocated = lists:keydelete(MId, 1, Allocated),
    {Total, NewAllocated}.

find_free_block(Allocated, Size) ->
    Sorted = lists:keysort(2, Allocated),
    find_free_block(Sorted, 0, Size).

find_free_block([], Start, Size) ->
    {Start, []};
find_free_block([{_, BlockStart, BlockSize} | Rest], Start, Size) ->
    if
        BlockStart - Start >= Size ->
            {Start, Rest};
        true ->
            NewStart = BlockStart + BlockSize,
            find_free_block(Rest, NewStart, Size)
    end.