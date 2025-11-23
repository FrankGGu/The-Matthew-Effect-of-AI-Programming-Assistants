-module(trie).
-export([new/0, insert/2, search/2, startsWith/2]).

new() -> {trie, #{}}.

insert(Trie, Word) ->
    insert(Trie, Word, 0).

search(Trie, Word) ->
    search(Trie, Word, 0).

startsWith(Trie, Prefix) ->
    startsWith(Trie, Prefix, 0).

insert({trie, Node}, Word, Index) ->
    case string:len(Word) =:= Index of
        true ->
            {trie, Node#{'#' => true}};
        false ->
            Char = string:substr(Word, Index + 1, 1),
            case maps:is_key(Char, Node) of
                true ->
                    {trie, Node#{Char => insert({trie, maps:get(Char, Node)}, Word, Index + 1)}};
                false ->
                    {trie, Node#{Char => insert({trie, #{}}, Word, Index + 1)}}
            end
    end.

search({trie, Node}, Word, Index) ->
    case string:len(Word) =:= Index of
        true ->
            maps:is_key('#', Node);
        false ->
            Char = string:substr(Word, Index + 1, 1),
            case maps:is_key(Char, Node) of
                true ->
                    search({trie, maps:get(Char, Node)}, Word, Index + 1);
                false ->
                    false
            end
    end.

startsWith({trie, Node}, Prefix, Index) ->
    case string:len(Prefix) =:= Index of
        true ->
            true;
        false ->
            Char = string:substr(Prefix, Index + 1, 1),
            case maps:is_key(Char, Node) of
                true ->
                    startsWith({trie, maps:get(Char, Node)}, Prefix, Index + 1);
                false ->
                    false
            end
    end.