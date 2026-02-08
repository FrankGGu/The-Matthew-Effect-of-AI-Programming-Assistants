-module(solution).
-export([minimum_length_encoding/1]).

minimum_length_encoding(Words) ->
    UniqueWords = lists:usort(Words),
    Trie = build_trie(UniqueWords),
    calculate_length(UniqueWords, Trie, 0).

build_trie(Words) ->
    lists:foldl(fun(Word, Trie) -> insert_word(lists:reverse(Word), Trie) end, #{}, Words).

insert_word([], Trie) ->
    Trie;
insert_word([Char | Rest], Trie) ->
    case maps:is_key(Char, Trie) of
        true -> 
            SubTrie = maps:get(Char, Trie),
            NewSubTrie = insert_word(Rest, SubTrie),
            maps:put(Char, NewSubTrie, Trie);
        false ->
            SubTrie = insert_word(Rest, #{}),
            maps:put(Char, SubTrie, Trie)
    end.

calculate_length([], _Trie, Acc) -> Acc;
calculate_length([Word | Rest], Trie, Acc) ->
    case is_suffix(Word, Trie) of
        true -> calculate_length(Rest, Trie, Acc);
        false -> calculate_length(Rest, Trie, Acc + length(Word) + 1)
    end.

is_suffix(Word, Trie) ->
    is_suffix_helper(lists:reverse(Word), Trie).

is_suffix_helper([], _Trie) -> false;
is_suffix_helper([Char], Trie) -> maps:is_key(Char, Trie);
is_suffix_helper([Char | Rest], Trie) ->
    case maps:is_key(Char, Trie) of
        true -> is_suffix_helper(Rest, maps:get(Char, Trie));
        false -> false
    end.