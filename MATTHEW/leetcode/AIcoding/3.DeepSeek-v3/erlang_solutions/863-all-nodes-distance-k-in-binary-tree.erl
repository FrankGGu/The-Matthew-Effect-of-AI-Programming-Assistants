-spec distance_k(Root :: #tree_node{} | null, Target :: #tree_node{} | null, K :: integer()) -> [integer()].
distance_k(Root, Target, K) ->
    case Root of
        null -> [];
        _ ->
            ParentMap = build_parent_map(Root, #{}, null),
            Visited = sets:new(),
            Queue = queue:in({Target, 0}, queue:new()),
            Result = bfs(Queue, ParentMap, Visited, K, []),
            Result
    end.

build_parent_map(Node, Map, Parent) ->
    case Node of
        null -> Map;
        _ ->
            Map1 = maps:put(Node, Parent, Map),
            Map2 = build_parent_map(Node#tree_node.left, Map1, Node),
            build_parent_map(Node#tree_node.right, Map2, Node)
    end.

bfs(Queue, ParentMap, Visited, K, Result) ->
    case queue:is_empty(Queue) of
        true -> Result;
        false ->
            {{Node, Distance}, NewQueue} = queue:out(Queue),
            case sets:is_element(Node, Visited) of
                true -> bfs(NewQueue, ParentMap, Visited, K, Result);
                false ->
                    Visited1 = sets:add_element(Node, Visited),
                    case Distance of
                        K -> bfs(NewQueue, ParentMap, Visited1, K, [Node#tree_node.val | Result]);
                        _ ->
                            Parent = maps:get(Node, ParentMap),
                            Children = [Node#tree_node.left, Node#tree_node.right, Parent],
                            Filtered = lists:filter(fun(X) -> X =/= null end, Children),
                            Queue1 = lists:foldl(fun(Child, Q) -> queue:in({Child, Distance + 1}, Q) end, NewQueue, Filtered),
                            bfs(Queue1, ParentMap, Visited1, K, Result)
                    end
            end
    end.