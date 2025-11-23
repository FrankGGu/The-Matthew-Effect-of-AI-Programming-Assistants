-module(trie).
-export([new/0, insert/2, search/2, starts_with/2]).

new() ->
    {dict, dict:new()}.

insert(Trie, Word) ->
    insert(Trie, Word, 1).

insert({dict, D}, [C | Rest], Pos) ->
    case dict:is_key(C, D) of
        true ->
            SubTrie = dict:fetch(C, D),
            insert(SubTrie, Rest, Pos + 1);
        false ->
            NewSubTrie = {dict, dict:new()},
            NewDict = dict:store(C, NewSubTrie, D),
            insert({dict, NewDict}, Rest, Pos + 1)
    end;
insert(Trie, [], _) ->
    Trie.

search({dict, D}, Word) ->
    search(D, Word, 1).

search(Dict, [C | Rest], Pos) ->
    case dict:is_key(C, Dict) of
        true ->
            SubTrie = dict:fetch(C, Dict),
            search(SubTrie, Rest, Pos + 1);
        false ->
            false
    end;
search(_, [], _) ->
    true.

starts_with({dict, D}, Prefix) ->
    starts_with(D, Prefix, 1).

starts_with(Dict, [C | Rest], Pos) ->
    case dict:is_key(C, Dict) of
        true ->
            SubTrie = dict:fetch(C, Dict),
            starts_with(SubTrie, Rest, Pos + 1);
        false ->
            false
    end;
starts_with(_, [], _) ->
    true.