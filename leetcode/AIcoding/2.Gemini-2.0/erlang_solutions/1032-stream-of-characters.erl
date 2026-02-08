-module(stream_of_characters).
-export([new/1, query/2]).

-record(trie, {children = dict:new(), is_word = false}).
-type trie() :: #trie{}.

-spec new([string()]) -> trie().
new(words) ->
    lists:foldl(fun(Word, Trie) -> insert(Word, Trie) end, #trie{}, words).

insert(Word, Trie) ->
    insert(Word, Trie, length(Word)).

insert([], Trie, _) ->
    Trie#trie{is_word = true};
insert([H|T], Trie, N) ->
    Char = list_to_atom([H]),
    case dict:find(Char, Trie#trie.children) of
        {ok, NextTrie} ->
            NewChildren = dict:update(Char, insert(T, NextTrie, N - 1), Trie#trie.children);
            Trie#trie{children = NewChildren};
        error ->
            NewTrie = insert(T, #trie{}, N - 1);
            NewChildren = dict:put(Char, NewTrie, Trie#trie.children);
            Trie#trie{children = NewChildren}
    end.

-spec query(trie(), string()) -> boolean().
query(Trie, Stream) ->
    query(Trie, lists:reverse(Stream)).

query(Trie, []) ->
    false;
query(Trie, [H|T]) ->
    Char = list_to_atom([H]),
    case dict:find(Char, Trie#trie.children) of
        {ok, NextTrie} ->
            (NextTrie#trie.is_word) orelse query(NextTrie, T);
        error ->
            Trie#trie.is_word orelse query(Trie, T)
    end.