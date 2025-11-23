-module(trie).
-export([new/0, insert/2, starts_with/2]).

new() ->
    dict:new().

insert(Trie, Word) ->
    insert(Trie, Word, 1).

insert(Trie, [], _) ->
    Trie;
insert(Trie, [Char | Rest], Level) ->
    SubTrie = dict:get(Char, Trie, dict:new()),
    NewSubTrie = insert(SubTrie, Rest, Level + 1),
    dict:store(Char, NewSubTrie, Trie).

starts_with(Trie, Prefix) ->
    starts_with(Trie, Prefix, 1).

starts_with(Trie, [], _) ->
    true;
starts_with(Trie, [Char | Rest], Level) ->
    case dict:find(Char, Trie) of
        {ok, SubTrie} ->
            starts_with(SubTrie, Rest, Level + 1);
        _ ->
            false
    end.