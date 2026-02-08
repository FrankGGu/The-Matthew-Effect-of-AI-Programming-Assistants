-spec inventory_management(Inventory :: [integer()], K :: integer()) -> [integer()].
inventory_management(Inventory, K) ->
    Sorted = lists:sort(Inventory),
    lists:sublist(Sorted, K).