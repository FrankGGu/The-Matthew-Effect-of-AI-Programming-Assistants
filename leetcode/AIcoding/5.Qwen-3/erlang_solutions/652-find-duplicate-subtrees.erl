-module(find_duplicate_subtrees).
-export([find_duplicates/1]).

find_duplicates(nil) -> [];
find_duplicates(Root) ->
    {_, _, Result} = traverse(Root, #{}),
    Result.

traverse(nil, _) -> {[], #{}};
traverse(Node, Map) ->
    {LeftSubs, LeftMap} = traverse(Node#tree.left, Map),
    {RightSubs, RightMap} = traverse(Node#tree.right, LeftMap),
    Subtree = {Node#tree.val, LeftSubs, RightSubs},
    Key = term_to_binary(Subtree),
    case maps:is_key(Key, RightMap) of
        true ->
            {Subtree, maps:put(Key, maps:get(Key, RightMap) + 1, RightMap), [Node | maps:get(Key, RightMap)]};
        false ->
            {Subtree, maps:put(Key, 1, RightMap), []}
    end.