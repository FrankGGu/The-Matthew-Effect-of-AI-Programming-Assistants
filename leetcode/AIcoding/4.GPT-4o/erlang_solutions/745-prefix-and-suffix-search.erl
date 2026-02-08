-module(PrefixAndSuffixSearch).
-export([new/1, f/2]).

-record(trie, {children = #{}, index = []}).

new(Words) ->
    Root = #trie{},
    Trie = lists:foldl(fun(W, Acc) -> insert(Acc, W) end, Root, Words),
    Trie.

insert(Trie, Word) ->
    Trie1 = insert_suffix(Trie, Word, length(Word)),
    lists:foldl(fun(Prefix, Acc) -> insert_prefix(Acc, Prefix, Word) end, Trie1, prefixes(Word)).

insert_suffix(Trie, Word, Len) ->
    case Len of
        0 -> Trie#trie{index = [Word | Trie#index]};
        _ -> 
            [Suffix | _] = lists:reverse(lists:seq(1, Len)),
            SuffixTrie = maps:get(lists:nth(Suffix, Word), Trie#trie.children, #trie{}),
            Trie2 = insert_suffix(SuffixTrie, Word, Len - 1),
            Trie#trie{children = maps:put(lists:nth(Suffix, Word), Trie2, Trie#trie.children)}
    end.

insert_prefix(Trie, Prefix, Word) ->
    PrefixTrie = maps:get(lists:nth(1, Prefix), Trie#trie.children, #trie{}),
    NewPrefixTrie = PrefixTrie#trie{index = [Word | PrefixTrie#index]},
    Trie#trie{children = maps:put(lists:nth(1, Prefix), NewPrefixTrie, Trie#trie.children)}.

prefixes(Word) ->
    lists:map(fun(X) -> lists:sublist(Word, 1, X) end, lists:seq(1, length(Word))).

f(Trie, Prefix) ->
    case maps:get(Prefix, Trie#trie.children, #trie{index = []}) of
        #trie{index = Index} -> lists:reverse(Index);
        _ -> []
    end.