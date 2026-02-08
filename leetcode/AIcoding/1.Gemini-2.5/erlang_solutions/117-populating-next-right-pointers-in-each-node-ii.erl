-module(solution).
-export([connect/1]).

-record(node, {val, left, right, next}).

-spec connect(Root :: node() | null) -> node() | null.
connect(null) -> null;
connect(Root) ->
    Q = queue:new(),
    Q1 = queue:in(Root, Q),
    bfs(Q1),
    Root.

bfs(Q) ->
    case queue:is_empty(Q) of
        true -> ok;
        false ->
            LevelSize = queue:len(Q),
            {NewQ, _LastNodeOfLevel} = process_level(LevelSize, Q, null),
            bfs(NewQ)
    end.

process_level(0, Q, PrevNode) -> {Q, PrevNode};
process_level(N, Q, PrevNode) ->
    {value, CurrentNode, Q1} = queue:out(Q),

    case PrevNode of
        null -> ok;
        _ -> _ = PrevNode#node{next = CurrentNode}
    end,

    Q_with_children = add_children_to_queue(CurrentNode, Q1),
    process_level(N-1, Q_with_children, CurrentNode).

add_children_to_queue(Node, Q) ->
    Q1 = case Node#node.left of
             null -> Q;
             Left -> queue:in(Left, Q)
         end,
    case Node#node.right of
        null -> Q1;
        Right -> queue:in(Right, Q1)
    end.