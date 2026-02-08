-module(solution).

-export([copyRandomList/1]).

-record(node, {val, next = null, random = null}).

copyRandomList(Head) ->
    {NewHead, _Map} = do_copy(Head, #{}),
    NewHead.

do_copy(null, Map) ->
    {null, Map};
do_copy(OldNode, Map) ->
    case Map of
        #{OldNode := NewNode} ->
            % If OldNode is already in the map, it means we've either fully processed it
            % or we're currently processing it (and this is a cycle/random pointer
            % pointing back to an ancestor in the call stack).
            % In either case, return the NewNode (which might be a stub if it's an ancestor).
            {NewNode, Map};
        _ ->
            % OldNode not in map, so create a new node stub for it.
            % This stub only has the 'val' initially. 'next' and 'random' are null.
            NewNodeStub = #node{val = OldNode#node.val},

            % Add the stub to the map. This is crucial for handling cycles:
            % if a 'next' or 'random' pointer later points back to OldNode,
            % it will find NewNodeStub in the map and use it.
            MapWithStub = Map#{OldNode => NewNodeStub},

            % Recursively copy the 'next' node.
            % This call will return the fully formed NewNextNode and an updated map.
            {NewNextNode, MapAfterNext} = do_copy(OldNode#node.next, MapWithStub),

            % Recursively copy the 'random' node.
            % This call will return the fully formed NewRandomNode and a further updated map.
            {NewRandomNode, MapAfterRandom} = do_copy(OldNode#node.random, MapAfterNext),

            % Now, create the *final* NewNode by updating the stub's next and random fields.
            % Since records are immutable, this creates a *new* record.
            FinalNewNode = NewNodeStub#node{next = NewNextNode, random = NewRandomNode},

            % Update the map: replace the NewNodeStub with the FinalNewNode.
            % This ensures that any subsequent lookups for OldNode will get the fully formed node.
            FinalMap = MapAfterRandom#{OldNode => FinalNewNode},

            {FinalNewNode, FinalMap}
    end.