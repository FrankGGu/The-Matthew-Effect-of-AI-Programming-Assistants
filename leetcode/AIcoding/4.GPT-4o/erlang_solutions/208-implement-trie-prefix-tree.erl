%% Definition for Trie
%% -record(trie_node, {children = #{}, is_end = false}).

-spec trie_init() -> #trie_node{}.
trie_init() ->
    #trie_node{children = #{}, is_end = false}.

-spec trie_insert(#trie_node{}, unicode:unicode_binary()) -> #trie_node{}.
trie_insert(Trie, Word) ->
    trie_insert(Trie, Word, 1).

-spec trie_insert(#trie_node{}, unicode:unicode_binary(), integer()) -> #trie_node{}.
trie_insert(Trie, <<>>, _) -> Trie#trie_node{is_end = true};
trie_insert(Trie, <<Char:8, Rest/binary>>, Index) ->
    Children = Trie#trie_node.children,
    case maps:get(Char, Children, undefined) of
        undefined ->
            NewChild = #trie_node{children = #{}, is_end = false},
            NewChildren = maps:put(Char, trie_insert(NewChild, Rest, Index + 1), Children),
            Trie#trie_node{children = NewChildren};
        _Child ->
            NewChildren = maps:put(Char, trie_insert(maps:get(Char, Children), Rest, Index + 1), Children),
            Trie#trie_node{children = NewChildren}
    end.

-spec trie_search(#trie_node{}, unicode:unicode_binary()) -> boolean().
trie_search(Trie, <<>>) -> Trie#trie_node.is_end;
trie_search(Trie, <<Char:8, Rest/binary>>) ->
    case maps:get(Char, Trie#trie_node.children, undefined) of
        undefined -> false;
        Child -> trie_search(Child, Rest)
    end.

-spec trie_starts_with(#trie_node{}, unicode:unicode_binary()) -> boolean().
trie_starts_with(Trie, <<>>) -> true;
trie_starts_with(Trie, <<Char:8, Rest/binary>>) ->
    case maps:get(Char, Trie#trie_node.children, undefined) of
        undefined -> false;
        Child -> trie_starts_with(Child, Rest)
    end.
