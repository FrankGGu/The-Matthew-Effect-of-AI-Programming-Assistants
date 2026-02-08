-module(solution).

-export([longestCommonSuffixQueries/2]).

-record(trie_node, {
    children = #{} :: #{char() => trie_node()},
    max_len = 0 :: integer(),
    min_idx = 1_000_000_000 :: integer() % Using a large number for an "infinity" placeholder for min_idx
}).

longestCommonSuffixQueries(Words, Queries) ->
    Trie = build_trie(Words),
    lists:map(fun(Q) -> query(Q, Trie) end, Queries).

build_trie(Words) ->
    InitialTrie = #trie_node{}, % Root node initialized with max_len=0, min_idx=infinity
    lists:foldl(
        fun({Word, Index}, AccTrie) ->
            insert_word(Word, Index, AccTrie)
        end,
        InitialTrie,
        lists:zip(Words, lists:seq(0, length(Words) - 1))
    ).

insert_word(Word, Index, Root) ->
    WordRev = lists:reverse(Word),
    Len = length(Word),
    insert_word_path(WordRev, Len, Index, Root).

insert_word_path([Char | Rest], Len, Index, CurrentNode) ->
    UpdatedCurrentNode = update_node_info(CurrentNode, Len, Index),

    Children = UpdatedCurrentNode#trie_node.children,
    case maps:find(Char, Children) of
        {ok, ChildNode} ->
            NewChildNode = insert_word_path(Rest, Len, Index, ChildNode),
            UpdatedCurrentNode#trie_node{children = maps:put(Char, NewChildNode, Children)};
        _ ->
            NewChildNode = insert_word_path(Rest, Len, Index, #trie_node{}),
            UpdatedCurrentNode#trie_node{children = maps:put(Char, NewChildNode, Children)}
    end.
insert_word_path([], Len, Index, CurrentNode) ->
    update_node_info(CurrentNode, Len, Index).

update_node_info(Node, NewLen, NewIdx) ->
    CurrentMaxLen = Node#trie_node.max_len,
    CurrentMinIdx = Node#trie_node.min_idx,
    case update_best_val(CurrentMaxLen, CurrentMinIdx, NewLen, NewIdx) of
        {UpdatedMaxLen, UpdatedMinIdx} ->
            Node#trie_node{max_len = UpdatedMaxLen, min_idx = UpdatedMinIdx}
    end.

update_best_val(CurrentMaxLen, CurrentMinIdx, NewLen, NewIdx) ->
    if
        NewLen > CurrentMaxLen -> {NewLen, NewIdx};
        NewLen == CurrentMaxLen andalso NewIdx < CurrentMinIdx -> {NewLen, NewIdx};
        true -> {CurrentMaxLen, CurrentMinIdx}
    end.

query(QueryString, Trie) ->
    QueryRev = lists:reverse(QueryString),
    {BestLen, BestIdx} = query_rec(QueryRev, Trie, 0, 1_000_000_000),
    if
        BestIdx == 1_000_000_000 -> -1;
        true -> BestIdx
    end.

query_rec([Char | Rest], CurrentNode, AccMaxLen, AccMinIdx) ->
    {NewAccMaxLen, NewAccMinIdx} = update_best_val(AccMaxLen, AccMinIdx, CurrentNode#trie_node.max_len, CurrentNode#trie_node.min_idx),

    Children = CurrentNode#trie_node.children,
    case maps:find(Char, Children) of
        {ok, ChildNode} ->
            query_rec(Rest, ChildNode, NewAccMaxLen, NewAccMinIdx);
        _ ->
            {NewAccMaxLen, NewAccMinIdx}
    end.
query_rec([], CurrentNode, AccMaxLen, AccMinIdx) ->
    update_best_val(AccMaxLen, AccMinIdx, CurrentNode#trie_node.max_len, CurrentNode#trie_node.min_idx).