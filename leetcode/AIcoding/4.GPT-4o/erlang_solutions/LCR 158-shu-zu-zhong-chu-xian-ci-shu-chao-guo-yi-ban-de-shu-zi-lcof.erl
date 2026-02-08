-module(solution).
-export([inventory_management/2]).

inventory_management/2 ->
    inventory_management(1, 0, 0, 0, 0).

inventory_management(ItemCount, Total, Max, Min, Count) when ItemCount =< 0 ->
    Total + (Max - Min) * Count;
inventory_management(ItemCount, Total, Max, Min, Count) ->
    NewMax = max(Max, ItemCount),
    NewMin = min(Min, ItemCount),
    NewCount = Count + 1,
    inventory_management(ItemCount - 1, Total, NewMax, NewMin, NewCount).