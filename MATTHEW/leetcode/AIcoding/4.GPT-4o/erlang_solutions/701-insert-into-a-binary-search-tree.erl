-module(solution).
-export([insert/2]).

-record(node, {val, left = null, right = null}).

insert(null, Value) ->
    #node{val = Value};
insert(#node{val = Val, left = Left, right = Right} = Node, Value) when Value < Val ->
    Node#node{left = insert(Left, Value)};
insert(#node{val = Val, left = Left, right = Right} = Node, Value) when Value > Val ->
    Node#node{right = insert(Right, Value)};
insert(Node, _) ->
    Node.