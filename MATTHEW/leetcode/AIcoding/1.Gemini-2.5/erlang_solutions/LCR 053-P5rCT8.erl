-module(solution).
-export([inorder_successor/2]).

inorder_successor(Root, P) ->
    case P of
        #{right := RightP} when RightP =/= nil ->
            find_min(RightP);
        _ ->
            find_successor_ancestor(Root, P, nil)
    end.

find_min(#{left := nil} = Node) ->
    Node;
find_min(#{left := Left} = _Node) ->
    find_min(Left);
find_min(nil) ->
    nil.

find_successor_ancestor(nil, _P, Successor) ->
    Successor;
find_successor_ancestor(#{val := RootVal, left := Left, right := Right} = RootNode, #{val := PVal} = PNode, CurrentSuccessor) ->
    if
        PVal >= RootVal ->
            find_successor_ancestor(Right, PNode, CurrentSuccessor);
        PVal < RootVal ->
            find_successor_ancestor(Left, PNode, RootNode)
    end.