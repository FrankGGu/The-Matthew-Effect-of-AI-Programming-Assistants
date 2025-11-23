-module(solution).
-export([find_shortest_subarray/1]).

find_shortest_subarray(Nums) ->
    {Degree, First, Last} = lists:foldl(fun (Num, {Degree, First, Last}, Index) ->
        case maps:is_key(Num, First) of
            true -> 
                {Degree, First, maps:update(Num, fun(X) -> X + 1 end, Last)}
            false -> 
                {Degree + 1, maps:put(Num, Index, First), maps:put(Num, Index, Last)}
        end
    end, {0, maps:new(), maps:new()}, Nums),
    lists:min(lists:map(fun (Num) -> maps:get(Num, Last) - maps:get(Num, First) + 1 end, maps:keys(First))).