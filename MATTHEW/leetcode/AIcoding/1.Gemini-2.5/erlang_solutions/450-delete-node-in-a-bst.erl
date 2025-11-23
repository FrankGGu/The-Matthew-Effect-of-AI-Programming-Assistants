-module(solution).
-export([delete_node/2]).

delete_node(nil, _Key) ->
    nil;
delete_node(#{val := Val, left := Left, right := Right} = Node, Key) when Key < Val ->
    Node#{left := delete_node(Left, Key)};
delete_node(#{val := Val, left := Left, right := Right} = Node, Key) when Key > Val ->
    Node#{right := delete_node(Right, Key)};
delete_node(#{val := _Val, left := Left, right := Right}, Key) -> % Key == _Val, node to be deleted
    case {Left, Right} of
        {nil, nil} ->
            nil;
        {nil, _} ->
            Right;
        {_, nil} ->
            Left;
        {_, _} ->
            Successor = find_min(Right),
            NewRight = delete_node(Right, Successor#val),
            Successor#{left := Left, right := NewRight}
    end.

find_min(#{left := nil} = Node) ->
    Node;
find_min(#{left := Left}) ->
    find_min(Left).