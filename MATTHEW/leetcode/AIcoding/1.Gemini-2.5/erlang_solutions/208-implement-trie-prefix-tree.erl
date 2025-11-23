-module(solution).
-export([new/0, insert/2, search/2, startsWith/2]).

new() ->
    #{}.

insert(Trie, Word) ->
    insert_recursive(Trie, Word).

insert_recursive(CurrentNode, []) ->
    maps:put('_end_of_word', true, CurrentNode);
insert_recursive(CurrentNode, [Char | Rest]) ->
    ChildNode = maps:get(Char, CurrentNode, #{}),
    UpdatedChildNode = insert_recursive(ChildNode, Rest),
    maps:put(Char, UpdatedChildNode, CurrentNode).

search(Trie, Word) ->
    search_recursive(Trie, Word).

search_recursive(CurrentNode, []) ->
    maps:is_key('_end_of_word', CurrentNode);
search_recursive(CurrentNode, [Char | Rest]) ->
    case maps:find(Char, CurrentNode) of
        {ok, ChildNode} ->
            search_recursive(ChildNode, Rest);
        error ->
            false
    end.

startsWith(Trie, Prefix) ->
    startsWith_recursive(Trie, Prefix).

startsWith_recursive(_CurrentNode, []) ->
    true;
startsWith_recursive(CurrentNode, [Char | Rest]) ->
    case maps:find(Char, CurrentNode) of
        {ok, ChildNode} ->
            startsWith_recursive(ChildNode, Rest);
        error ->
            false
    end.