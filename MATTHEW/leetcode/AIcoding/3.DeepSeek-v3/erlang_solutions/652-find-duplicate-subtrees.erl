-spec find_duplicate_subtrees(Root :: treeNode() | null) -> [treeNode()].
find_duplicate_subtrees(Root) ->
    Map = maps:new(),
    Result = [],
    {_, NewMap, NewResult} = traverse(Root, Map, Result),
    NewResult.

traverse(null, Map, Result) ->
    {"#", Map, Result};
traverse(Node, Map, Result) ->
    {LeftKey, Map1, Result1} = traverse(Node#treeNode.left, Map, Result),
    {RightKey, Map2, Result2} = traverse(Node#treeNode.right, Map1, Result1),
    Key = lists:concat([Node#treeNode.val, ",", LeftKey, ",", RightKey]),
    Count = maps:get(Key, Map2, 0),
    NewMap = maps:put(Key, Count + 1, Map2),
    NewResult = if
        Count =:= 1 -> [Node | Result2];
        true -> Result2
    end,
    {Key, NewMap, NewResult}.