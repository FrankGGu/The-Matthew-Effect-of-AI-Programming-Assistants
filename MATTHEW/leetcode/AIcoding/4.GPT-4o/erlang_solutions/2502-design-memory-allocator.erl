-module(memory_allocator).
-export([new/1, allocate/1, deallocate/1]).

-record(block, {size, free}).

new(Size) ->
    State = #block{size = Size, free = Size},
    put(state, State).

allocate(Size) ->
    State = get(state),
    AllocatedSize = allocate_block(State, Size),
    case AllocatedSize of
        {ok, AllocatedBlock} -> 
            NewFree = State#block.free - AllocatedSize,
            NewState = State#block{free = NewFree},
            put(state, NewState),
            {ok, AllocatedBlock};
        error -> 
            error
    end.

deallocate(Size) ->
    State = get(state),
    NewFree = State#block.free + Size,
    NewState = State#block{free = NewFree},
    put(state, NewState),
    ok.

allocate_block(State, Size) when Size =< State#block.free -> 
    {ok, Size};
allocate_block(_, _) -> 
    error.

put(Key, Value) -> 
    erlang:put(Key, Value).

get(Key) -> 
    erlang:get(Key).