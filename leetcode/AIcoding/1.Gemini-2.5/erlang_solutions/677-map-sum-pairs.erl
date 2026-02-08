-module(map_sum_pairs).

-export([new/0, insert/3, sum/2]).

-record(node, {children = #{}, value = 0, sum = 0}).
-record(map_sum_state, {trie_root = #node{}, key_values = #{} }).

new() ->
    #map_sum_state{trie_root = #node{children = #{}, value = 0, sum = 0},
                   key_values = #{} }.

insert(#map_sum_state{trie_root = Root, key_values = KeyValues} = State, Key, Val) ->
    OldVal = maps:get(Key, KeyValues, 0),
    Diff = Val - OldVal,
    NewKeyValues = maps:put(Key, Val, KeyValues),
    NewRoot = insert_trie_node_recursive(Root, Key, Diff, Val, true),
    State#map_sum_state{trie_root = NewRoot, key_values = NewKeyValues}.

insert_trie_node_recursive(Node, [], Diff, FinalVal, IsEndOfKey) ->
    NewValue = if IsEndOfKey -> FinalVal;
                 true -> Node#node.value
               end,
    Node#node{value = NewValue, sum = Node#node.sum + Diff};
insert_trie_node_recursive(Node, [H|T], Diff, FinalVal, IsEndOfKey) ->
    Child = maps:get(H, Node#node.children, #node{children = #{}, value = 0, sum = 0}),
    NewChild = insert_trie_node_recursive(Child, T, Diff, FinalVal, IsEndOfKey and T == []),
    NewChildren = maps:put(H, NewChild, Node#node.children),
    Node#node{children = NewChildren, sum = Node#node.sum + Diff}.

sum(#map_sum_state{trie_root = Root}, Prefix) ->
    get_prefix_sum(Root, Prefix).

get_prefix_sum(Node, []) ->
    Node#node.sum;
get_prefix_sum(Node, [H|T]) ->
    case maps:get(H, Node#node.children, undefined) of
        undefined -> 0;
        Child -> get_prefix_sum(Child, T)
    end.