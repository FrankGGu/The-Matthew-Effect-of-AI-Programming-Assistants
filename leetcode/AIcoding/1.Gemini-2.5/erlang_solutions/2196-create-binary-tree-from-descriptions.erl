-module(solution).
-export([create_binary_tree/1]).

-record(tree_node, {val, left = null, right = null}).

create_binary_tree(Descriptions) ->
    InitialState = {maps:new(), gb_sets:new()}, % {NodesMap, ChildrenSet}

    {FinalNodesMap, FinalChildrenSet} = lists:foldl(
        fun([ParentVal, ChildVal, IsLeft], {NodesMap, ChildrenSet}) ->
            NewChildrenSet = gb_sets:add(ChildVal, ChildrenSet),

            ParentNode = maps:get(ParentVal, NodesMap, #tree_node{val = ParentVal}),
            ChildNode = maps:get(ChildVal, NodesMap, #tree_node{val = ChildVal}),

            UpdatedParentNode = 
                case IsLeft of
                    1 -> ParentNode#tree_node{left = ChildNode};
                    0 -> ParentNode#tree_node{right = ChildNode}
                end,

            NewNodesMap1 = maps:put(ParentVal, UpdatedParentNode, NodesMap),
            NewNodesMap2 = maps:put(ChildVal, ChildNode, NewNodesMap1),

            {NewNodesMap2, NewChildrenSet}
        end,
        InitialState,
        Descriptions
    ),

    RootValList = lists:filter(
        fun(Val) -> not gb_sets:is_member(Val, FinalChildrenSet) end,
        maps:keys(FinalNodesMap)
    ),

    RootVal = hd(RootValList),
    maps:get(RootVal, FinalNodesMap).