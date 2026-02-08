-module(prefix_scores).
-export([sum_prefix_scores/1]).

sum_prefix_scores(Words) ->
    Trie = build_trie(Words),
    lists:sum([score(Word, Trie) || Word <- Words]).

build_trie(Words) ->
    lists:foldl(fun(Word, Trie) -> insert(Word, Trie) end, #{}, Words).

insert([], Trie) ->
    Trie#{'$' => 1};
insert([H|T], Trie) ->
    case maps:find(H, Trie) of
        {ok, SubTrie} ->
            Trie#{H => insert(T, SubTrie)};
        error ->
            Trie#{H => insert(T, #{})}
    end.

score(Word, Trie) ->
    score_helper(Word, Trie, 0).

score_helper([], _, Acc) ->
    Acc;
score_helper([H|T], Trie, Acc) ->
    case maps:find(H, Trie) of
        {ok, SubTrie} ->
            Count = count_prefix(SubTrie),
            score_helper(T, SubTrie, Acc + Count);
        error ->
            Acc
    end.

count_prefix(Trie) ->
    count_prefix_helper(Trie, 0).

count_prefix_helper(Trie, Acc) ->
    case maps:find('$', Trie) of
        {ok, _} ->
            Acc + 1;
        error ->
            Acc
    end + lists:sum([count_prefix_helper(V, 0) || {_, V} <- maps:to_list(maps:remove(['$'], Trie))]).