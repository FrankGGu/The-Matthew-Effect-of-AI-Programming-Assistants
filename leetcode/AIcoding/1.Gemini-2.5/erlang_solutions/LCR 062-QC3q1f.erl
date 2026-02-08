-module(trie).
-export([new/0, insert/2, search/2, startsWith/2]).

new() ->
    #{}.

insert(Trie, Word) ->
    insert_char(Trie, Word).

insert_char(CurrentNode, []) ->
    maps:put('$end$', true, CurrentNode);
insert_char(CurrentNode, [H|T]) ->
    ChildNode = maps:get(H, CurrentNode, #{}),
    NewChildNode = insert_char(ChildNode, T),
    maps:put(H, NewChildNode, CurrentNode).

search(Trie, Word) ->
    search_char(Trie, Word).

search_char(CurrentNode, []) ->
    maps:is_key('$end$', CurrentNode);
search_char(CurrentNode, [H|T]) ->
    case maps:find(H, CurrentNode) of
        {ok, ChildNode} ->
            search_char(ChildNode, T);
        _ ->
            false
    end.

startsWith(Trie, Prefix) ->
    starts_with_char(Trie, Prefix).

starts_with_char(_CurrentNode, []) ->
    true;
starts_with_char(CurrentNode, [H|T]) ->
    case maps:find(H, CurrentNode) of
        {ok, ChildNode} ->
            starts_with_char(ChildNode, T);
        _ ->
            false
    end.