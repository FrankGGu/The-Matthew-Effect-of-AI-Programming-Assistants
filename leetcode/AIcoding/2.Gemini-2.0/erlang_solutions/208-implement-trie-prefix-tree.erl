-module(trie).
-export([new/0, insert/2, search/2, startsWith/2]).

new() ->
    #{}.

insert(Trie, Word) ->
    insert_helper(Trie, string:to_list(Word)).

search(Trie, Word) ->
    search_helper(Trie, string:to_list(Word)).

startsWith(Trie, Prefix) ->
    starts_with_helper(Trie, string:to_list(Prefix)).

insert_helper(Trie, []) ->
    Trie#{'$' => true};
insert_helper(Trie, [H|T]) ->
    case maps:is_key(H, Trie) of
        true ->
            NewTrie = maps:get(H, Trie),
            Trie#{H => insert_helper(NewTrie, T)};
        false ->
            Trie#{H => insert_helper(#{}, T)}
    end.

search_helper(Trie, []) ->
    maps:get($, Trie, false);
search_helper(Trie, [H|T]) ->
    case maps:is_key(H, Trie) of
        true ->
            NewTrie = maps:get(H, Trie),
            search_helper(NewTrie, T);
        false ->
            false
    end.

starts_with_helper(Trie, []) ->
    true;
starts_with_helper(Trie, [H|T]) ->
    case maps:is_key(H, Trie) of
        true ->
            NewTrie = maps:get(H, Trie),
            starts_with_helper(NewTrie, T);
        false ->
            false
    end.