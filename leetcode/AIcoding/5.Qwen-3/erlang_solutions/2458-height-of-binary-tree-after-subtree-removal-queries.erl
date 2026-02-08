-module(solution).
-export([treeQueries/2]).

treeQueries(Root, Queries) ->
    {HeightMap, _} = build_height_map(Root, 0),
    [get_new_height(Root, Q, HeightMap) || Q <- Queries].

build_height_map(nil, _) -> {#{}, 0};
build_height_map({Val, Left, Right}, Level) ->
    {LeftMap, LeftHeight} = build_height_map(Left, Level + 1),
    {RightMap, RightHeight} = build_height_map(Right, Level + 1),
    CurrentHeight = max(LeftHeight, RightHeight) + 1,
    Map = maps:put(Val, CurrentHeight, maps:merge(LeftMap, RightMap)),
    {Map, CurrentHeight}.

get_new_height(nil, _, _) -> 0;
get_new_height({Val, Left, Right}, Query, HeightMap) ->
    if
        Val == Query ->
            % Remove this node, calculate new height
            LeftHeight = case Left of nil -> 0; _ -> maps:get(Val, HeightMap) end,
            RightHeight = case Right of nil -> 0; _ -> maps:get(Val, HeightMap) end,
            max(LeftHeight, RightHeight);
        true ->
            % Recurse on left and right
            LeftResult = get_new_height(Left, Query, HeightMap),
            RightResult = get_new_height(Right, Query, HeightMap),
            max(LeftResult, RightResult)
    end.