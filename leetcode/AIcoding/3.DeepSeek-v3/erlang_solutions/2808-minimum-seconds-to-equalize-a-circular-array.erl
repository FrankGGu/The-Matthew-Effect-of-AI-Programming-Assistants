-module(solution).
-export([minimum_seconds/1]).

minimum_seconds(Nums) ->
    N = length(Nums),
    Map = lists:foldl(fun(X, Acc) ->
        dict:append(X, 1, Acc)
    end, dict:new(), lists:zip(lists:seq(0, N-1), nums_to_list(Nums))),
    Dict = dict:fold(fun(Key, Value, Acc) ->
        dict:store(Key, lists:sort(Value), Acc)
    end, dict:new(), Map),
    MaxGap = dict:fold(fun(_, List, Max) ->
        Gap = calculate_max_gap(List, N),
        max(Max, Gap)
    end, 0, Dict),
    MaxGap div 2.

nums_to_list(Nums) -> Nums.

calculate_max_gap([H|T], N) ->
    calculate_max_gap(T, H, H, N).

calculate_max_gap([], First, Prev, N) ->
    max(Prev - First, N - Prev + First);
calculate_max_gap([H|T], First, Prev, N) ->
    max(H - Prev, calculate_max_gap(T, First, H, N)).