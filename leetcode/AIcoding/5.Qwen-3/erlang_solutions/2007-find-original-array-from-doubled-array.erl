-module(find_original_array_from_doubled_array).
-export([find_original/1]).

find_original(Nums) ->
    Map = lists:foldl(fun(N, Acc) -> 
        Count = maps:get(N, Acc, 0),
        maps:put(N, Count + 1, Acc)
    end, #{}, Nums),
    Sorted = lists:sort(Nums),
    Result = [],
    find_original_helper(Sorted, Map, Result).

find_original_helper([], _, Result) ->
    Result;
find_original_helper([N | Rest], Map, Result) ->
    Count = maps:get(N, Map, 0),
    if
        Count == 0 ->
            find_original_helper(Rest, Map, Result);
        true ->
            case N of
                0 ->
                    if
                        Count rem 2 == 0 ->
                            NewMap = maps:put(N, Count - 1, Map),
                            find_original_helper(Rest, NewMap, [N | Result]);
                        true ->
                            error
                    end;
                _ ->
                    Double = N * 2,
                    DoubleCount = maps:get(Double, Map, 0),
                    if
                        DoubleCount >= 1 ->
                            NewMap = maps:put(N, Count - 1, maps:put(Double, DoubleCount - 1, Map)),
                            find_original_helper(Rest, NewMap, [N | Result]);
                        true ->
                            error
                    end
            end
    end.