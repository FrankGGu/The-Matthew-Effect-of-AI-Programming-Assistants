-record(tree_node, {val, left = nil, right = nil}).

-export([get_directions/3]).

get_directions(Root, StartValue, DestValue) ->
    LCA = find_lca(Root, StartValue, DestValue),

    PathToStart = find_path_from_lca(LCA, StartValue, []),
    PathToDest = find_path_from_lca(LCA, DestValue, []),

    UpMoves = lists:duplicate(length(PathToStart), $U),
    DownMoves = PathToDest,

    UpMoves ++ DownMoves.

find_lca(nil, _, _) -> nil;
find_lca(Node = #tree_node{val = Val}, StartVal, DestVal) when Val == StartVal; Val == DestVal -> Node;
find_lca(Node = #tree_node{left = Left, right = Right}, StartVal, DestVal) ->
    LeftLCA = find_lca(Left, StartVal, DestVal),
    RightLCA = find_lca(Right, StartVal, DestVal),

    case {LeftLCA, RightLCA} of
        {nil, nil} -> nil;
        {nil, _} -> RightLCA;
        {_, nil} -> LeftLCA;
        {_, _} -> Node
    end.

find_path_from_lca(nil, _, _) -> [];
find_path_from_lca(#tree_node{val = TargetVal}, TargetVal, Acc) -> lists:reverse(Acc);
find_path_from_lca(#tree_node{val = _, left = Left, right = Right}, TargetVal, Acc) ->
    PathInLeft = find_path_from_lca(Left, TargetVal, [$L | Acc]),
    case PathInLeft of
        [] ->
            find_path_from_lca(Right, TargetVal, [$R | Acc]);
        _ -> PathInLeft
    end.