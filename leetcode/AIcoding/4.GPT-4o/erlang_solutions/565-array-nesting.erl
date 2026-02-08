-module(solution).
-export([array_nesting/1]).

array_nesting(Nums) ->
    array_nesting(Nums, length(Nums), 0).

array_nesting([], _, Max) -> 
    Max;
array_nesting(Nums, Len, Max) -> 
    array_nesting(Nums, Len, Max, []).

array_nesting(_, 0, Max, _) -> 
    Max;
array_nesting(Nums, Len, Max, Visited) -> 
    case lists:find(fun(N) -> not lists:member(N, Visited) end, Nums) of
        none -> 
            Max;
        {ok, Start} -> 
            Length = array_nesting_helper(Nums, Start, Visited, 0),
            NewMax = max(Length, Max),
            array_nesting(Nums, Len - 1, NewMax, [])
    end.

array_nesting_helper(Nums, Start, Visited, Count) -> 
    if 
        lists:member(Start, Visited) -> 
            Count; 
        true -> 
            array_nesting_helper(Nums, lists:nth(Start + 1, Nums), [Start | Visited], Count + 1)
    end.