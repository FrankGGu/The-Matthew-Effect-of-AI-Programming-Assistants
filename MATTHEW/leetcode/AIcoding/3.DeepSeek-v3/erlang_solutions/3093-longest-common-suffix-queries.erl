-module(solution).
-export([longest_common_suffix_queries/2]).

longest_common_suffix_queries(WordsContainer, WordsQuery) ->
    Trie = build_trie(WordsContainer),
    lists:map(fun(Query) -> query_trie(Trie, Query) end, WordsQuery).

build_trie(Words) ->
    build_trie(Words, #{}).

build_trie([], Trie) -> Trie;
build_trie([Word | Rest], Trie) ->
    Index = length(Rest),
    NewTrie = insert_word(Word, Word, Index, Trie),
    build_trie(Rest, NewTrie).

insert_word(Word, Original, Index, Trie) ->
    insert_word_reversed(lists:reverse(Word), Original, Index, Trie).

insert_word_reversed([], Original, Index, Trie) ->
    case maps:get('$', Trie, undefined) of
        undefined -> Trie#{ '$' => {Original, Index} };
        {_, ExistingIndex} when Index < ExistingIndex -> Trie#{ '$' => {Original, Index} };
        _ -> Trie
    end;
insert_word_reversed([Char | Rest], Original, Index, Trie) ->
    SubTrie = maps:get(Char, Trie, #{}),
    UpdatedSubTrie = insert_word_reversed(Rest, Original, Index, SubTrie),
    case maps:get('$', UpdatedSubTrie, undefined) of
        undefined ->
            case maps:get(Char, Trie, undefined) of
                undefined -> Trie#{ Char => UpdatedSubTrie };
                _ -> Trie#{ Char := UpdatedSubTrie }
            end;
        {_, NewIndex} ->
            case maps:get(Char, Trie, undefined) of
                undefined -> Trie#{ Char => UpdatedSubTrie };
                _ ->
                    case maps:get('$', Trie, undefined) of
                        undefined -> Trie#{ Char := UpdatedSubTrie };
                        {_, ExistingIndex} when NewIndex < ExistingIndex ->
                            Trie#{ Char := UpdatedSubTrie, '$' => {Original, NewIndex} };
                        _ -> Trie#{ Char := UpdatedSubTrie }
                    end
            end
    end.

query_trie(Trie, Query) ->
    query_trie_reversed(lists:reverse(Query), Trie).

query_trie_reversed(Query, Trie) ->
    query_trie_reversed(Query, Trie, {hd(maps:get('$', Trie, {<<"">>, 0})), 0}).

query_trie_reversed([], _, {Word, _}) -> Word;
query_trie_reversed(_, Trie, {Word, _}) when not is_map(Trie) -> Word;
query_trie_reversed([Char | Rest], Trie, {CurrentWord, CurrentIndex}) ->
    case maps:get('$', Trie, undefined) of
        {NewWord, NewIndex} when NewIndex < CurrentIndex ->
            NewCurrent = {NewWord, NewIndex};
        {NewWord, NewIndex} when NewIndex =:= CurrentIndex andalso byte_size(NewWord) < byte_size(CurrentWord) ->
            NewCurrent = {NewWord, NewIndex};
        _ ->
            NewCurrent = {CurrentWord, CurrentIndex}
    end,
    case maps:get(Char, Trie, undefined) of
        undefined -> CurrentWord;
        SubTrie -> query_trie_reversed(Rest, SubTrie, NewCurrent)
    end.