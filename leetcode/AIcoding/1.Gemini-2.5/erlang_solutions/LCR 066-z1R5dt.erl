-module(solution).
-export([new/0, insert/3, sum/2]).

-define(EMPTY_TRIE_NODE, #{children => #{}, current_val => 0, prefix_sum => 0}).

new() ->
    ?EMPTY_TRIE_NODE#{key_values => #{}}.

insert(Key, Val, Root) ->
    KeyChars = unicode:characters_to_list(Key),
    KeyValues = maps:get(key_values, Root),
    OldVal = maps:get(Key, KeyValues, 0),
    Diff = Val - OldVal,

    NewKeyValues = maps:put(Key, Val, KeyValues),

    TrieRoot = maps:remove(key_values, Root),
    NewTrieRoot = insert_recursive(KeyChars, TrieRoot, Diff, Val),
    NewTrieRoot#{key_values := NewKeyValues}.

insert_recursive([], CurrentNode, Diff, FinalVal) ->
    CurrentNode#{current_val := FinalVal, prefix_sum := maps:get(prefix_sum, CurrentNode) + Diff};
insert_recursive([Char|Rest], CurrentNode, Diff, FinalVal) ->
    Children = maps:get(children, CurrentNode),
    Child = maps:get(Char, Children, ?EMPTY_TRIE_NODE),
    NewChild = insert_recursive(Rest, Child, Diff, FinalVal),
    NewChildren = maps:put(Char, NewChild, Children),
    CurrentNode#{children := NewChildren, prefix_sum := maps:get(prefix_sum, CurrentNode) + Diff}.

sum(Prefix, Root) ->
    PrefixChars = unicode:characters_to_list(Prefix),
    TrieRoot = maps:remove(key_values, Root),
    sum_recursive(PrefixChars, TrieRoot).

sum_recursive([], CurrentNode) ->
    maps:get(prefix_sum, CurrentNode);
sum_recursive([Char|Rest], CurrentNode) ->
    Children = maps:get(children, CurrentNode),
    case maps:find(Char, Children) of
        {ok, Child} ->
            sum_recursive(Rest, Child);
        _ ->
            0
    end.