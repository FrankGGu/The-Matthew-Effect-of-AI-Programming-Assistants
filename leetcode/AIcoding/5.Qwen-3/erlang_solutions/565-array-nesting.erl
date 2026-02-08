-module(array_nesting).
-export([array_nesting/1]).

array_nesting(Nums) ->
    Max = length(Nums),
    Visited = lists:duplicate(Max, false),
    array_nesting(Nums, Visited, 0, 0).

array_nesting(_, _, I, Max) when I >= length(Nums) ->
    Max;

array_nesting(Nums, Visited, I, Max) ->
    if
        lists:nth(I + 1, Visited) == true ->
            array_nesting(Nums, Visited, I + 1, Max);
        true ->
            Start = I,
            Current = I,
            Count = 0,
            {NewVisited, _} = traverse(Nums, Visited, Current, Count),
            NewMax = max(Max, Count),
            array_nesting(Nums, NewVisited, Start + 1, NewMax)
    end.

traverse(_, Visited, Current, Count) when Current >= length(Nums) ->
    {Visited, Count};

traverse(Nums, Visited, Current, Count) ->
    case lists:nth(Current + 1, Visited) of
        true ->
            {Visited, Count};
        false ->
            NewVisited = lists:sublist(Visited, Current) ++ [true] ++ lists:nthtail(Current + 1, Visited),
            Next = lists:nth(Current + 1, Nums),
            traverse(Nums, NewVisited, Next, Count + 1)
    end.