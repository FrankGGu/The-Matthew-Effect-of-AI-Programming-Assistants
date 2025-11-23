-module(cbt_inserter).
-export([new/1, insert/2, get_root/1]).

-record(treenode, {val, left = nil, right = nil}).
-record(cbt_inserter_state, {root, queue}). % queue stores {Node, PathToNode} tuples

q_new() -> {[], []}.
q_in(E, {F, B}) -> {F, [E | B]}.
q_out({[], []}) -> {empty, {[], []}};
q_out({[H|T], B}) -> {H, {T, B}};
q_out({[], B}) -> q_out({lists:reverse(B), []}).

update_tree(Root, PathToNode, UpdatedNode) ->
    lists:foldr(
        fun({Ancestor, Direction}, ChildNode) ->
            case Direction of
                left -> Ancestor#treenode{left = ChildNode};
                right -> Ancestor#treenode{right = ChildNode}
            end
        end,
        UpdatedNode,
        PathToNode
    ).

new(Root) ->
    InserterQueue = q_new(),
    BFSQueue = q_in({Root, []}, q_new()), % BFS queue stores {Node, PathToNode}
    FinalInserterQueue = build_inserter_queue_bfs(BFSQueue, InserterQueue),
    #cbt_inserter_state{root = Root, queue = FinalInserterQueue}.

build_inserter_queue_bfs(BFSQueue, InserterQueue) ->
    case q_out(BFSQueue) of
        {empty, _} ->
            InserterQueue;
        {{Node, PathToNode}, RestBFSQueue} ->
            % Add Node to InserterQueue if it has an empty slot
            NextInserterQueue = case {Node#treenode.left, Node#treenode.right} of
                                    {nil, _} -> q_in({Node, PathToNode}, InserterQueue);
                                    {_, nil} -> q_in({Node, PathToNode}, InserterQueue);
                                    _ -> InserterQueue % Both children exist, not a potential parent
                                end,

            % Add children to BFSQueue with their respective paths
            BFSQueueWithChildren = case Node#treenode.left of
                                       nil -> RestBFSQueue;
                                       Left -> q_in({Left, PathToNode ++ [{Node, left}]}, RestBFSQueue)
                                   end,
            FinalBFSQueue = case Node#treenode.right of
                                nil -> BFSQueueWithChildren;
                                Right -> q_in({Right, PathToNode ++ [{Node, right}]}, BFSQueueWithChildren)
                            end,
            build_inserter_queue_bfs(FinalBFSQueue, NextInserterQueue)
    end.

insert(Val, #cbt_inserter_state{root = CurrentRoot, queue = InserterQueue} = State) ->
    {{Parent, PathToParent}, TempInserterQueue} = q_out(InserterQueue), % Dequeue the parent
    NewNode = #treenode{val = Val},

    ReturnVal = Parent#treenode.val,

    NewRoot = CurrentRoot, % Will be updated
    FinalInserterQueue = TempInserterQueue, % Will be updated

    case Parent#treenode.left of
        nil -> % Insert as left child
            UpdatedParent = Parent#treenode{left = NewNode},
            NewRoot = update_tree(CurrentRoot, PathToParent, UpdatedParent),

            % Parent still has an empty right slot, so re-enqueue it (with its updated version and path)
            QueueAfterParent = q_in({UpdatedParent, PathToParent}, TempInserterQueue),
            % The new node also has empty slots, so enqueue it (with its path)
            FinalInserterQueue = q_in({NewNode, PathToParent ++ [{UpdatedParent, left}]}, QueueAfterParent);
        _ -> % Insert as right child
            UpdatedParent = Parent#treenode{right = NewNode},
            NewRoot = update_tree(CurrentRoot, PathToParent, UpdatedParent),

            % Parent now has both children, so it's not re-enqueued.
            % The new node has empty slots, so enqueue it (with its path).
            FinalInserterQueue = q_in({NewNode, PathToParent ++ [{UpdatedParent, right}]}, TempInserterQueue)
    end,

    {ReturnVal, #cbt_inserter_state{root = NewRoot, queue = FinalInserterQueue}}.

get_root(#cbt_inserter_state{root = Root, queue = _}) ->
    Root.