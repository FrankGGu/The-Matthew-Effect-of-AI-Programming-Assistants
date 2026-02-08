-module(key_value_map).
-export([start/0, insert/3, sum/2]).

-record(trie_node, {children = #{}, value = 0}).

start() ->
    #trie_node{}.

insert(Key, Val, Trie) ->
    insert_helper(Key, Val, Trie, 1).

insert_helper([], Val, Trie, _) ->
    Trie#trie_node{value = Val};
insert_helper([C | Rest], Val, Trie = #trie_node{children = Children}, Pos) ->
    Child = maps:get(C, Children, #trie_node{}),
    NewChild = insert_helper(Rest, Val, Child, Pos + 1),
    NewChildren = maps:put(C, NewChild, Children),
    Trie#trie_node{children = NewChildren}.

sum(Prefix, Trie) ->
    sum_helper(Prefix, Trie, 1).

sum_helper([], #trie_node{children = Children, value = Val}, _) ->
    Val + sum_children(Children);
sum_helper([C | Rest], #trie_node{children = Children}, Pos) ->
    case maps:find(C, Children) of
        {ok, Child} -> sum_helper(Rest, Child, Pos + 1);
        error -> 0
    end.

sum_children(Children) ->
    maps:fold(fun(_, #trie_node{value = Val, children = Ch}, Acc) ->
        Val + sum_children(Ch) + Acc
    end, 0, Children).