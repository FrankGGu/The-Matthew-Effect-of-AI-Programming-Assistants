-spec array_nesting(Nums :: [integer()]) -> integer().
array_nesting(Nums) ->
    N = length(Nums),
    Visited = array:new(N, {default, false}),
    Max = 0,
    array_nesting(Nums, Visited, 0, Max).

array_nesting(_, _, N, Max) when N =:= length(Max) -> Max;
array_nesting(Nums, Visited, I, Max) ->
    case array:get(I, Visited) of
        true ->
            array_nesting(Nums, Visited, I + 1, Max);
        false ->
            {NewVisited, Count} = dfs(Nums, Visited, I, 0),
            NewMax = max(Max, Count),
            array_nesting(Nums, NewVisited, I + 1, NewMax)
    end.

dfs(Nums, Visited, I, Count) ->
    case array:get(I, Visited) of
        true ->
            {Visited, Count};
        false ->
            NewVisited = array:set(I, true, Visited),
            Next = lists:nth(I + 1, Nums),
            dfs(Nums, NewVisited, Next, Count + 1)
    end.