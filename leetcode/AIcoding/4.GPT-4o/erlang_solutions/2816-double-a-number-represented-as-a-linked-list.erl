-module(solution).
-export([double_linked_list/1]).

-record(node, {value, next}).

double_linked_list(Node) ->
    double(Node, 0).

double(nil, 0) ->
    nil;
double(Node, Carry) ->
    NewValue = Node#node.value * 2 + Carry,
    NewCarry = NewValue div 10,
    NewNode = #node{value = NewValue rem 10, next = double(Node#node.next, NewCarry)},
    NewNode.