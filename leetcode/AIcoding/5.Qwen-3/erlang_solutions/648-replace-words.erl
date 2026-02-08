-module(replace_words).
-export([replace_words/2]).

replace_words(Roots, Sentence) ->
    Words = string:split(Sentence, " "),
    Trie = build_trie(Roots),
    lists:map(fun(W) -> find_prefix(W, Trie) end, Words).

build_trie(Roots) ->
    maps:new() ++ [ {lists:sublist(R, 1, I), true} || R <- Roots, I <- lists:seq(1, length(R)) ].

find_prefix([], _) -> "";
find_prefix([C|T], Trie) ->
    case maps:is_key([C|T], Trie) of
        true -> [C|T];
        false -> find_prefix(T, Trie)
    end.