-module(solution).
-export([containsNearbyAlmostDuplicate/4]).

containsNearbyAlmostDuplicate(Nums, k, t) ->
    containsNearbyAlmostDuplicate(Nums, k, t, 0).

containsNearbyAlmostDuplicate([], _, _, _) -> false;
containsNearbyAlmostDuplicate(Nums, k, t, Index) when Index < length(Nums) ->
    Num = lists:nth(Index + 1, Nums),
    case find_nearby(Nums, Num, Index, k, t) of
        true -> true;
        false -> containsNearbyAlmostDuplicate(Nums, k, t, Index + 1)
    end.

find_nearby(Nums, Num, Index, k, t) ->
    MinIndex = max(0, Index - k),
    MaxIndex = min(length(Nums) - 1, Index + k),
    lists:any(fun(I) ->
        I =\= Index,
        AbsDiff = abs(Num - lists:nth(I + 1, Nums)),
        AbsDiff =< t
    end, lists:seq(MinIndex, MaxIndex)).