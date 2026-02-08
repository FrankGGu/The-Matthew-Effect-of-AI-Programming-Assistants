-module(dinner_plate_stacks).
-export([new/1, push/2, pop/1, popAtStack/2]).

-record(state, {
    capacity :: integer(),
    stacks :: map(), % map of index -> {list(), size :: integer()}
    max_stack_idx :: integer(), % highest index ever used
    available_push_indices :: gb_trees:tree(), % indices of stacks that are not full
    non_empty_pop_indices :: gb_trees:tree() % indices of stacks that are not empty
}).

new(Capacity) ->
    #state{
        capacity = Capacity,
        stacks = #{},
        max_stack_idx = -1,
        available_push_indices = gb_trees:empty(),
        non_empty_pop_indices = gb_trees:empty()
    }.

push(Val, State0 = #state{capacity = Capacity, stacks = Stacks, max_stack_idx = MaxStackIdx, available_push_indices = AvailablePushIndices, non_empty_pop_indices = NonEmptyPopIndices}) ->
    IdxToPush = case gb_trees:is_empty(AvailablePushIndices) of
        true -> MaxStackIdx + 1;
        false -> gb_trees:smallest(AvailablePushIndices)
    end,

    {CurrentStack, CurrentSize} = maps:get(IdxToPush, Stacks, {[], 0}),

    NewStack = [Val | CurrentStack],
    NewSize = CurrentSize + 1,

    NewStacks = maps:put(IdxToPush, {NewStack, NewSize}, Stacks),
    NewMaxStackIdx = max(MaxStackIdx, IdxToPush),

    NewAvailablePushIndices = 
        if NewSize < Capacity ->
            gb_trees:insert(IdxToPush, true, AvailablePushIndices);
        true -> % NewSize == Capacity
            gb_trees:delete(IdxToPush, AvailablePushIndices)
        end,

    NewNonEmptyPopIndices = gb_trees:insert(IdxToPush, true, NonEmptyPopIndices),

    State0#state{
        stacks = NewStacks,
        max_stack_idx = NewMaxStackIdx,
        available_push_indices = NewAvailablePushIndices,
        non_empty_pop_indices = NewNonEmptyPopIndices
    }.

pop(State0 = #state{stacks = Stacks, available_push_indices = AvailablePushIndices, non_empty_pop_indices = NonEmptyPopIndices}) ->
    case gb_trees:is_empty(NonEmptyPopIndices) of
        true ->
            {-1, State0};
        false ->
            IdxToPop = gb_trees:largest(NonEmptyPopIndices),
            {CurrentStack, CurrentSize} = maps:get(IdxToPop, Stacks),

            Val = hd(CurrentStack),
            NewStack = tl(CurrentStack),
            NewSize = CurrentSize - 1,

            NewStacks = maps:put(IdxToPop, {NewStack, NewSize}, Stacks),

            NewAvailablePushIndices = gb_trees:insert(IdxToPop, true, AvailablePushIndices),

            NewNonEmptyPopIndices = 
                if NewSize == 0 ->
                    gb_trees:delete(IdxToPop, NonEmptyPopIndices);
                true ->
                    NonEmptyPopIndices
                end,

            {Val, State0#state{
                stacks = NewStacks,
                available_push_indices = NewAvailablePushIndices,
                non_empty_pop_indices = NewNonEmptyPopIndices
            }}
    end.

popAtStack(Index, State0 = #state{stacks = Stacks, max_stack_idx = MaxStackIdx, available_push_indices = AvailablePushIndices, non_empty_pop_indices = NonEmptyPopIndices}) ->
    case Index > MaxStackIdx orelse not maps:is_key(Index, Stacks) of
        true ->
            {-1, State0};
        false ->
            {CurrentStack, CurrentSize} = maps:get(Index, Stacks),
            case CurrentSize == 0 of
                true ->
                    {-1, State0};
                false ->
                    Val = hd(CurrentStack),
                    NewStack = tl(CurrentStack),
                    NewSize = CurrentSize - 1,

                    NewStacks = maps:put(Index, {NewStack, NewSize}, Stacks),

                    NewAvailablePushIndices = gb_trees:insert(Index, true, AvailablePushIndices),

                    NewNonEmptyPopIndices = 
                        if NewSize == 0 ->
                            gb_trees:delete(Index, NonEmptyPopIndices);
                        true ->
                            NonEmptyPopIndices
                        end,

                    {Val, State0#state{
                        stacks = NewStacks,
                        available_push_indices = NewAvailablePushIndices,
                        non_empty_pop_indices = NewNonEmptyPopIndices
                    }}
            end
    end.