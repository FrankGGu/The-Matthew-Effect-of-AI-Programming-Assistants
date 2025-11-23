-module(solution).
-export([unmarked_sum_array/2]).

unmarked_sum_array(Nums, Queries) ->
    {Sum, Map} = lists:foldl(fun(X, {Acc, M}) -> 
                                    {Acc + X, maps:put(X, maps:get(X, M, 0) + 1, M)} 
                            end, {0, #{}}, Nums),
    process_queries(Nums, Queries, Sum, Map).

process_queries(_, [], Sum, _) -> [Sum];
process_queries(Nums, [[Index, K] | Rest], Sum, Map) ->
    Value = lists:nth(Index + 1, Nums),
    case maps:get(Value, Map, 0) of
        0 -> 
            process_queries(Nums, Rest, Sum, Map);
        Count ->
            NewCount = Count - 1,
            NewMap = if 
                        NewCount =:= 0 -> maps:remove(Value, Map);
                        true -> maps:put(Value, NewCount, Map)
                     end,
            NewSum = Sum - Value,
            process_k_smallest(Nums, Rest, NewSum, NewMap, K)
    end.

process_k_smallest(Nums, Queries, Sum, Map, K) ->
    SortedKeys = lists:sort(maps:keys(Map)),
    {NewSum, NewMap} = take_k_smallest(SortedKeys, Sum, Map, K),
    [Sum | process_queries(Nums, Queries, NewSum, NewMap)].

take_k_smallest(_, Sum, Map, 0) -> {Sum, Map};
take_k_smallest([], Sum, Map, _) -> {Sum, Map};
take_k_smallest([Key | Rest], Sum, Map, K) ->
    Count = maps:get(Key, Map),
    ToTake = min(Count, K),
    NewSum = Sum - Key * ToTake,
    NewMap = if 
                 ToTake =:= Count -> maps:remove(Key, Map);
                 true -> maps:put(Key, Count - ToTake, Map)
              end,
    take_k_smallest(Rest, NewSum, NewMap, K - ToTake).