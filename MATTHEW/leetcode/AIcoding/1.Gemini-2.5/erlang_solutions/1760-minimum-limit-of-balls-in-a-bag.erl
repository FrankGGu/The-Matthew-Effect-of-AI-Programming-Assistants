-module(solution).
-export([minimum_limit/2]).

minimum_limit(Nums, MaxOperations) ->
    Low = 1,
    High = lists:max(Nums),
    binary_search(Low, High, High, Nums, MaxOperations).

binary_search(Low, High, Ans, _Nums, _MaxOperations) when Low > High ->
    Ans;
binary_search(Low, High, CurrentAns, Nums, MaxOperations) ->
    Mid = Low + (High - Low) div 2,
    OpsNeeded = check(Mid, Nums),
    case OpsNeeded =< MaxOperations of
        true ->
            binary_search(Low, Mid - 1, Mid, Nums, MaxOperations);
        false ->
            binary_search(Mid + 1, High, CurrentAns, Nums, MaxOperations)
    end.

check(Limit, Nums) ->
    lists:foldl(fun(X, Acc) ->
        case X > Limit of
            true -> Acc + ((X - 1) div Limit);
            false -> Acc
        end
    end, 0, Nums).