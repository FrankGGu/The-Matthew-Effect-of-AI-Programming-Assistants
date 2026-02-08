-record(trie_node, {
    children = #{},
    is_end = false
}).

-spec init_() -> any().
init_() ->
    #trie_node{}.

-spec insert(Word :: unicode:unicode_binary()) -> any().
insert(Word) ->
    Root = get(trie_root),
    NewRoot = insert_helper(Root, Word),
    put(trie_root, NewRoot).

insert_helper(Node, <<>>) ->
    Node#trie_node{is_end = true};
insert_helper(Node, <<Char, Rest/binary>>) ->
    Children = Node#trie_node.children,
    Child = maps:get(Char, Children, #trie_node{}),
    NewChild = insert_helper(Child, Rest),
    NewChildren = maps:put(Char, NewChild, Children),
    Node#trie_node{children = NewChildren}.

-spec search(Word :: unicode:unicode_binary()) -> boolean().
search(Word) ->
    Root = get(trie_root),
    case search_helper(Root, Word) of
        {found, IsEnd} -> IsEnd;
        not_found -> false
    end.

search_helper(Node, <<>>) ->
    {found, Node#trie_node.is_end};
search_helper(Node, <<Char, Rest/binary>>) ->
    Children = Node#trie_node.children,
    case maps:find(Char, Children) of
        {ok, Child} -> search_helper(Child, Rest);
        error -> not_found
    end.

-spec starts_with(Prefix :: unicode:unicode_binary()) -> boolean().
starts_with(Prefix) ->
    Root = get(trie_root),
    case search_helper(Root, Prefix) of
        {found, _} -> true;
        not_found -> false
    end.