-module(map_sum).

-export([init/0, insert/2, sum/1]).

-record(node, {children = #{}, value = 0}).

init() ->
    #node{}.

insert(Key, Val) ->
    put(trie, insert_internal(Key, Val, get(trie))).

insert_internal([], Val, Node) ->
    Node#node{value = Val};
insert_internal([Char | Rest], Val, #node{children = Children} = Node) ->
    Child = maps:get(Char, Children, #node{}),
    NewChild = insert_internal(Rest, Val, Child),
    Node#node{children = Children#{Char => NewChild}}.

sum(Prefix) ->
    Node = find_node(Prefix, get(trie)),
    sum_node(Node).

find_node([], Node) ->
    Node;
find_node([Char | Rest], #node{children = Children}) ->
    case maps:get(Char, Children, undefined) of
        undefined -> #node{};
        Child -> find_node(Rest, Child)
    end.

sum_node(#node{children = Children, value = Val}) ->
    maps:fold(fun(_, Child, Acc) -> Acc + sum_node(Child) end, Val, Children).