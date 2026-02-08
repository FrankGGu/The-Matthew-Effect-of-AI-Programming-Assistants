-module(word_filter).
-export([init/1, f/3]).

init(Words) ->
    Trie = build_trie(Words),
    {Trie, length(Words)}.

build_trie(Words) ->
    lists:foldl(fun(Word, Trie) ->
        N = length(Word),
        WordWithIndices = lists:zip(lists:seq(1, N), Word),
        Suffixes = [lists:sublist(Word, I) || I <- lists:seq(1, N)],
        Prefixes = [lists:sublist(Word, N - I + 1, I) || I <- lists:seq(1, N)],
        lists:foldl(fun({I, C}, Acc) ->
            Suffix = lists:sublist(Word, I),
            Prefix = lists:sublist(Word, N - I + 1, I),
            insert_word(Acc, {Suffix, Prefix}, I - 1)
        end, Trie, WordWithIndices)
    end, dict:new(), Words).

insert_word(Trie, {Suffix, Prefix}, Index) ->
    Key = {Suffix, Prefix},
    case dict:find(Key, Trie) of
        {ok, _} -> 
            dict:store(Key, Index, Trie);
        error -> 
            dict:store(Key, Index, Trie)
    end.

f(_Trie, _Size, Prefix, Suffix) ->
    Key = {Suffix, Prefix},
    case dict:find(Key, _Trie) of
        {ok, Index} -> Index;
        error -> -1
    end.