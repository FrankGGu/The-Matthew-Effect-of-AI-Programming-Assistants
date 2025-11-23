-module(solution).
-export([sum_prefix_scores/1]).

sum_prefix_scores(Words) ->
    Trie = build_trie(Words),
    lists:map(fun(Word) -> calculate_score(Word, Trie) end, Words).

build_trie(Words) ->
    lists:foldl(fun(Word, Trie) -> insert_word(Word, Trie) end, #{}, Words).

insert_word(Word, Trie) ->
    insert_word(Word, 1, length(Word), Trie).

insert_word(Word, Pos, Len, Trie) when Pos =< Len ->
    Prefix = string:slice(Word, 0, Pos),
    UpdatedTrie = maps:update_with(Prefix, fun(V) -> V + 1 end, 1, Trie),
    insert_word(Word, Pos + 1, Len, UpdatedTrie);
insert_word(_Word, _Pos, _Len, Trie) ->
    Trie.

calculate_score(Word, Trie) ->
    calculate_score(Word, 1, length(Word), 0, Trie).

calculate_score(Word, Pos, Len, Score, Trie) when Pos =< Len ->
    Prefix = string:slice(Word, 0, Pos),
    case maps:get(Prefix, Trie, 0) of
        0 -> Score;
        Count -> calculate_score(Word, Pos + 1, Len, Score + Count, Trie)
    end;
calculate_score(_Word, _Pos, _Len, Score, _Trie) ->
    Score.