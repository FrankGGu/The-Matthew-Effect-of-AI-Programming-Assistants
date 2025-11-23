-module(all_oone_data_structure).

-export([new/0, inc/2, dec/2, get_max_key/1, get_min_key/1]).

-record(node, {
    id      :: integer(),
    count   :: integer(),
    keys    :: #{binary() => true}, % A set of keys
    prev_id :: integer() | nil,
    next_id :: integer() | nil
}).

-record(state, {
    key_to_count    :: #{binary() => integer()},       % Key -> Count
    count_to_node_id :: #{integer() => integer()},      % Count -> NodeId
    nodes           :: #{integer() => #node{}},        % NodeId -> NodeRecord
    head_id         :: integer() | nil,                % NodeId of the smallest count node
    tail_id         :: integer() | nil,                % NodeId of the largest count node
    next_node_id_counter :: integer()                   % For generating unique NodeIds
}).

new() ->
    #state{
        key_to_count = #{},
        count_to_node_id = #{},
        nodes = #{},
        head_id = nil,
        tail_id = nil,
        next_node_id_counter = 1
    }.

inc(State, Key) ->
    OldCount = maps:get(Key, State#state.key_to_count, 0),
    NewCount = OldCount + 1,

    % Update key_to_count
    State1 = State#state{key_to_count = maps:put(Key, NewCount, State#state.key_to_count)},

    PrevNodeIdForInsertion = nil, % This will be the node *before* where NewNode goes

    % 1. Process OldCount's node (if OldCount > 0)
    State2 = if OldCount > 0 ->
        OldNodeId = maps:get(OldCount, State1#state.count_to_node_id),
        OldNode = maps:get(OldNodeId, State1#state.nodes),
        UpdatedOldNodeKeys = maps:remove(Key, OldNode#node.keys),

        if maps:size(UpdatedOldNodeKeys) == 0 -> % OldNode becomes empty, delete it
            % Store prev_id before deleting, as OldNodeId might be removed
            PrevNodeIdForInsertion_ = OldNode#node.prev_id,
            StateWithDeleted = delete_node_from_list(State1, OldNodeId),
            {StateWithDeleted#state{count_to_node_id = maps:remove(OldCount, StateWithDeleted#state.count_to_node_id)}, PrevNodeIdForInsertion_};
        true -> % OldNode still has keys, just update it
            PrevNodeIdForInsertion_ = OldNodeId, % NewNode goes after OldNode
            {State1#state{nodes = maps:put(OldNodeId, OldNode#node{keys = UpdatedOldNodeKeys}, State1#state.nodes)}, PrevNodeIdForInsertion_}
        end;
    true -> % OldCount == 0, no old node to process
        {State1, nil}
    end,
    {State2a, PrevNodeIdForInsertion_} = State2, % Unpack the tuple

    % 2. Process NewCount's node
    NewNodeId = maps:get(NewCount, State2a#state.count_to_node_id, nil),
    State3 = if NewNodeId /= nil -> % NewCount node exists
        NewNode = maps:get(NewNodeId, State2a#state.nodes),
        UpdatedNewNodeKeys = maps:put(Key, true, NewNode#node.keys),
        State2a#state{nodes = maps:put(NewNodeId, NewNode#node{keys = UpdatedNewNodeKeys}, State2a#state.nodes)};
    true -> % NewCount node does NOT exist: Create and insert new node
        GeneratedNodeId = State2a#state.next_node_id_counter,
        NewNodeToInsert = #node{id = GeneratedNodeId, count = NewCount, keys = #{Key => true}, prev_id = nil, next_id = nil},

        StateWithNewNodeCounter = State2a#state{next_node_id_counter = GeneratedNodeId + 1},
        StateWithNewNodeId = StateWithNewNodeCounter#state{count_to_node_id = maps:put(NewCount, GeneratedNodeId, StateWithNewNodeCounter#state.count_to_node_id)},

        insert_node_after_prev(StateWithNewNodeId, NewNodeToInsert, PrevNodeIdForInsertion_)
    end,
    State3.

dec(State, Key) ->
    OldCount = maps:get(Key, State#state.key_to_count, 0),

    if OldCount == 0 -> % Key not present, do nothing
        State;
    true ->
        NewCount = OldCount - 1,

        % 1. Process OldCount's node
        OldNodeId = maps:get(OldCount, State#state.count_to_node_id),
        OldNode = maps:get(OldNodeId, State#state.nodes),
        UpdatedOldNodeKeys = maps:remove(Key, OldNode#node.keys),

        NextNodeIdForInsertion = nil, % This will be the node *after* where NewNode goes

        State1 = if maps:size(UpdatedOldNodeKeys) == 0 -> % OldNode becomes empty, delete it
            NextNodeIdForInsertion_ = OldNode#node.next_id,
            StateWithDeleted = delete_node_from_list(State#state{key_to_count = maps:remove(Key, State#state.key_to_count)}, OldNodeId),
            {StateWithDeleted#state{count_to_node_id = maps:remove(OldCount, StateWithDeleted#state.count_to_node_id)}, NextNodeIdForInsertion_};
        true -> % OldNode still has keys, just update it
            NextNodeIdForInsertion_ = OldNodeId, % NewNode goes before OldNode
            {State#state{nodes = maps:put(OldNodeId, OldNode#node{keys = UpdatedOldNodeKeys}, State#state.nodes)}, NextNodeIdForInsertion_}
        end,
        {State1a, NextNodeIdForInsertion_} = State1, % Unpack the tuple

        % 2. Process NewCount's node (if NewCount > 0)
        if NewCount > 0 ->
            % Update key_to_count
            State2 = State1a#state{key_to_count = maps:put(Key, NewCount, State1a#state.key_to_count)},

            NewNodeId = maps:get(NewCount, State2#state.count_to_node_id, nil),
            if NewNodeId /= nil -> % NewCount node exists
                NewNode = maps:get(NewNodeId, State2#state.nodes),
                UpdatedNewNodeKeys = maps:put(Key, true, NewNode#node.keys),
                State2#state{nodes = maps:put(NewNodeId, NewNode#node{keys = UpdatedNewNodeKeys}, State2#state.nodes)};
            true -> % NewCount node does NOT exist: Create and insert new node
                GeneratedNodeId = State2#state.next_node_id_counter,
                NewNodeToInsert = #node{id = GeneratedNodeId, count = NewCount, keys = #{Key => true}, prev_id = nil, next_id = nil},

                StateWithNewNodeCounter = State2#state{next_node_id_counter = GeneratedNodeId + 1},
                StateWithNewNodeId = StateWithNewNodeCounter#state{count_to_node_id = maps:put(NewCount, GeneratedNodeId, StateWithNewNodeCounter#state.count_to_node_id)},

                insert_node_before_next(StateWithNewNodeId, NewNodeToInsert, NextNodeIdForInsertion_)
            end;
        true -> % NewCount == 0, key is removed completely, key_to_count already handled
            State1a
        end
    end.

get_max_key(State) ->
    if State#state.tail_id == nil ->
        <<"">>;
    true ->
        TailNode = maps:get(State#state.tail_id, State#state.nodes),
        get_any_key_from_map(TailNode#node.keys)
    end.

get_min_key(State) ->
    if State#state.head_id == nil ->
        <<"">>;
    true ->
        HeadNode = maps:get(State#state.head_id, State#state.nodes),
        get_any_key_from_map(HeadNode#node.keys)
    end.

delete_node_from_list(State, NodeIdToDelete) ->
    NodeToDelete = maps:get(NodeIdToDelete, State#state.nodes),
    PrevId = NodeToDelete#node.prev_id,
    NextId = NodeToDelete#node.next_id,

    NewNodes = maps:remove(NodeIdToDelete, State#state.nodes),
    NewHeadId = if State#state.head_id == NodeIdToDelete -> NextId; true -> State#state.head_id end,
    NewTailId = if State#state.tail_id == NodeIdToDelete -> PrevId; true -> State#state.tail_id end,

    UpdatedNodes1 = if
        PrevId /= nil ->
            PrevNode = maps:get(PrevId, NewNodes),
            maps:put(PrevId, PrevNode#node{next_id = NextId}, NewNodes);
        true -> NewNodes
    end,
    UpdatedNodes2 = if
        NextId /= nil ->
            NextNode = maps:get(NextId, UpdatedNodes1),
            maps:put(NextId, NextNode#node{prev_id = PrevId}, UpdatedNodes1);
        true -> UpdatedNodes1
    end,
    State#state{nodes = UpdatedNodes2, head_id = NewHeadId, tail_id = NewTailId}.

insert_node_after_prev(State, NewNode, PrevNodeId) ->
    NewNodeId = NewNode#node.id,
    UpdatedNodes = maps:put(NewNodeId, NewNode, State#state.nodes),

    if PrevNodeId == nil -> % Insert at head (or as the only node)
        CurrentHeadId = State#state.head_id,
        if CurrentHeadId == nil -> % List was empty
            State#state{head_id = NewNodeId, tail_id = NewNodeId, nodes = UpdatedNodes};
        true -> % Insert before CurrentHead
            CurrentHeadNode = maps:get(CurrentHeadId, UpdatedNodes),
            NewNodeWithNext = NewNode#node{next_id = CurrentHeadId},
            CurrentHeadNodeWithPrev = CurrentHeadNode#node{prev_id = NewNodeId},
            State#state{
                head_id = NewNodeId,
                nodes = maps:put(NewNodeId, NewNodeWithNext, maps:put(CurrentHeadId, CurrentHeadNodeWithPrev, UpdatedNodes))
            }
        end;
    true -> % Insert after PrevNodeId
        PrevNode = maps:get(PrevNodeId, UpdatedNodes),
        NextNodeId = PrevNode#node.next_id,
        NewNodeWithPointers = NewNode#node{prev_id = PrevNodeId, next_id = NextNodeId},
        PrevNodeWithNext = PrevNode#node{next_id = NewNodeId},

        NewNodes1 = maps:put(PrevNodeId, PrevNodeWithNext, maps:put(NewNodeId, NewNodeWithPointers, UpdatedNodes)),

        FinalNodes = if NextNodeId /= nil ->
            NextNode = maps:get(NextNodeId, NewNodes1),
            NextNodeWithPrev = NextNode#node{prev_id = NewNodeId},
            maps:put(NextNodeId, NextNodeWithPrev, NewNodes1);
        true -> NewNodes1
        end,

        NewTailId = if NextNodeId == nil -> NewNodeId; true -> State#state.tail_id end,
        State#state{nodes = FinalNodes, tail_id = NewTailId}
    end.

insert_node_before_next(State, NewNode, NextNodeId) ->
    NewNodeId = NewNode#node.id,
    UpdatedNodes = maps:put(NewNodeId, NewNode, State#state.nodes),

    if NextNodeId == nil -> % Insert at tail (or as the only node)
        CurrentTailId = State#state.tail_id,
        if CurrentTailId == nil -> % List was empty
            State#state{head_id = NewNodeId, tail_id = NewNodeId, nodes = UpdatedNodes};
        true -> % Insert after CurrentTail
            CurrentTailNode = maps:get(CurrentTailId, UpdatedNodes),
            NewNodeWithPrev = NewNode#node{prev_id = CurrentTailId},
            CurrentTailNodeWithNext = CurrentTailNode#node{next_id = NewNodeId},
            State#state{
                tail_id = NewNodeId,
                nodes = maps:put(NewNodeId, NewNodeWithPrev, maps:put(CurrentTailId, CurrentTailNodeWithNext, UpdatedNodes))
            }
        end;
    true -> % Insert before NextNodeId
        NextNode = maps:get(NextNodeId, UpdatedNodes),
        PrevNodeId = NextNode#node.prev_id,
        NewNodeWithPointers = NewNode#node{prev_id = PrevNodeId, next_id = NextNodeId},
        NextNodeWithPrev = NextNode#node{prev_id = NewNodeId},

        NewNodes1 = maps:put(NextNodeId, NextNodeWithPrev, maps:put(NewNodeId, NewNodeWithPointers, UpdatedNodes)),

        FinalNodes = if PrevNodeId /= nil ->
            PrevNode = maps:get(PrevNodeId, NewNodes1),
            PrevNodeWithNext = PrevNode#node{next_id = NewNodeId},
            maps:put(PrevNodeId, PrevNodeWithNext, NewNodes1);
        true -> NewNodes1
        end,

        NewHeadId = if PrevNodeId == nil -> NewNodeId; true -> State#state.head_id end,
        State#state{nodes = FinalNodes, head_id = NewHeadId}
    end.

get_any_key_from_map(Map) when map_size(Map) > 0 ->
    {Key, _, _} = maps:next(maps:iterator(Map));
get_any_key_from_map(_) ->
    <<"">>.