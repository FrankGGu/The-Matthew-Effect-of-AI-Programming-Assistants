-record(treeNode, {val = 0 :: integer(),
                   left = null  :: 'null' | #treeNode{},
                   right = null :: 'null' | #treeNode{}}).

-spec vertical_traversal(Root :: #treeNode{} | null) -> [[integer()]].
vertical_traversal(Root) ->
    case Root of
        null -> [];
        _ ->
            Map = traverse(Root, 0, 0, #{}),
            Keys = lists:sort(maps:keys(Map)),
            lists:map(fun(Key) ->
                lists:map(fun({_Row, Val}) -> Val end,
                    lists:sort(maps:get(Key, Map)))
            end, Keys)
    end.

traverse(null, _Col, _Row, Map) -> Map;
traverse(Node, Col, Row, Map) ->
    Key = Col,
    NewMap = case maps:is_key(Key, Map) of
        true ->
            maps:put(Key, lists:sort([{Row, Node#treeNode.val} | maps:get(Key, Map)]), Map);
        false ->
            maps:put(Key, [{Row, Node#treeNode.val}], Map)
    end,
    LeftMap = traverse(Node#treeNode.left, Col - 1, Row + 1, NewMap),
    traverse(Node#treeNode.right, Col + 1, Row + 1, LeftMap).