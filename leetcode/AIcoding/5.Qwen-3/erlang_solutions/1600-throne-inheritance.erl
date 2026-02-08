-module(throne_inheritance).
-export([new/1, get_inheritance_order/1, birth/2, death/1]).

-record(node, {name, children, dead}).

new(First) ->
    #node{name = First, children = [], dead = false}.

birth(Parent, Child) ->
    ParentNode = get_node(Parent),
    ParentNode#node.children = [Child | ParentNode#node.children],
    ok.

death(Name) ->
    Node = get_node(Name),
    Node#node.dead = true,
    ok.

get_inheritance_order(Root) ->
    get_order(Root, []).

get_order(Node, Acc) ->
    case Node#node.dead of
        true -> Acc;
        false -> [Node#node.name | get_order_children(Node#node.children, Acc)]
    end.

get_order_children([], Acc) ->
    Acc;
get_order_children([Child | Rest], Acc) ->
    ChildNode = get_node(Child),
    get_order_children(Rest, get_order(ChildNode, Acc)).

get_node(Name) ->
    % This is a placeholder for the actual node lookup logic.
    % In a real implementation, you would have a map or a global registry of nodes.
    % For LeetCode purposes, this is simplified and assumes that nodes are stored in a way
    % that allows retrieval by name.
    erlang:error(not_implemented).