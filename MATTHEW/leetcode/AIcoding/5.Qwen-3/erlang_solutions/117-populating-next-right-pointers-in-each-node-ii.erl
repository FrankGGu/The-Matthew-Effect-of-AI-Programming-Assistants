-module(solution).
-export([connect/1]).

-record(tree_node, {val, left, right, next}).

connect(undefined) ->
    undefined;
connect(Node) ->
    Parent = Node,
    NextLevelHead = connect_next_level(Parent, undefined),
    connect_next_level_nodes(NextLevelHead),
    Node.

connect_next_level(undefined, _) ->
    undefined;
connect_next_level(Node, NextParent) ->
    case Node#tree_node.left of
        undefined ->
            connect_next_level(Node#tree_node.right, NextParent);
        Left ->
            case Node#tree_node.right of
                undefined ->
                    Left#tree_node{next = NextParent};
                Right ->
                    Left#tree_node{next = Right},
                    Right#tree_node{next = NextParent}
            end,
            connect_next_level(Node#tree_node.right, NextParent)
    end.

connect_next_level_nodes(undefined) ->
    ok;
connect_next_level_nodes(Node) ->
    case Node#tree_node.left of
        undefined ->
            connect_next_level_nodes(Node#tree_node.right);
        Left ->
            case Node#tree_node.right of
                undefined ->
                    Left#tree_node{next = Node#tree_node.next};
                Right ->
                    Left#tree_node{next = Right},
                    Right#tree_node{next = Node#tree_node.next}
            end,
            connect_next_level_nodes(Node#tree_node.right)
    end.