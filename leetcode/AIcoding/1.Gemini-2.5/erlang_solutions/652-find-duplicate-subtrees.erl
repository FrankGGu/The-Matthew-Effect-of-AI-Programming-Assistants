-module(solution).
-export([find_duplicate_subtrees/1]).

-spec find_duplicate_subtrees(Root :: tree_node() | null) -> [tree_node()].
find_duplicate_subtrees(Root) ->
    {_Serialized, _Map, Duplicates} = serialize_and_find(Root, maps:new(), []),
    Duplicates.

serialize_and_find(null, Map, Duplicates) ->
    {"#", Map, Duplicates};
serialize_and_find({tree_node, Val, Left, Right} = Node, Map, Duplicates) ->
    {LeftStr, Map1, Duplicates1} = serialize_and_find(Left, Map, Duplicates),
    {RightStr, Map2, Duplicates2} = serialize_and_find(Right, Map1, Duplicates1),

    CurrentStr = io_lib:format("~w,~s,~s", [Val, LeftStr, RightStr]),

    Count = maps:get(CurrentStr, Map2, 0),
    NewCount = Count + 1,
    NewMap = maps:put(CurrentStr, NewCount, Map2),

    NewDuplicates =
        if NewCount == 2 ->
                [Node | Duplicates2];
           true ->
                Duplicates2
        end,

    {CurrentStr, NewMap, NewDuplicates}.