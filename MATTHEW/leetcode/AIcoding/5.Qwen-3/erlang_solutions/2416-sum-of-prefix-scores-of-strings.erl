-module(sum_of_prefix_scores).
-export([prefix_score/1]).

prefix_score(Strings) ->
    Trie = build_trie(Strings),
    lists:map(fun(S) -> score(S, Trie) end, Strings).

build_trie(Strings) ->
    lists:foldl(fun(S, Acc) -> insert(Acc, S) end, #{}, Strings).

insert(Trie, []) ->
    Trie;
insert(Trie, [C | Rest]) ->
    Sub = maps:get(C, Trie, #{}),
    NewSub = insert(Sub, Rest),
    maps:put(C, NewSub, Trie).

score([], _) ->
    0;
score([C | Rest], Trie) ->
    case maps:find(C, Trie) of
        {ok, Sub} ->
            1 + score(Rest, Sub);
        error ->
            0
    end.