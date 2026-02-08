-module(solution).
-export([display_table/1]).

display_table(Orders) ->
    FoodSet = lists:foldl(fun(Order, Acc) ->
        [_, _, Food] = Order,
        sets:add_element(Food, Acc)
    end, sets:new(), Orders),
    FoodList = lists:sort(sets:to_list(FoodSet)),

    Tables = lists:foldl(fun(Order, Acc) ->
        [Table, _, _] = Order,
        sets:add_element(Table, Acc)
    end, sets:new(), Orders),
    TableList = lists:sort(sets:to_list(Tables)),

    FoodIndex = lists:zip(FoodList, lists:seq(1, length(FoodList))),
    TableMap = lists:zip(TableList, lists:seq(1, length(TableList))),

    CountMap = lists:foldl(fun(Order, Acc) ->
        [Table, _, Food] = Order,
        TableId = proplists:get_value(Table, TableMap),
        FoodId = proplists:get_value(Food, FoodIndex),
        Key = {TableId, FoodId},
        Count = maps:get(Key, Acc, 0) + 1,
        maps:put(Key, Count, Acc)
    end, #{}, Orders),

    Header = ["Table" | FoodList],
    Rows = lists:map(fun(Table) ->
        TableId = proplists:get_value(Table, TableMap),
        Row = lists:map(fun(Food) ->
            FoodId = proplists:get_value(Food, FoodIndex),
            maps:get({TableId, FoodId}, CountMap, 0)
        end, FoodList),
        [Table | lists:map(fun integer_to_list/1, Row)]
    end, TableList),

    [Header | Rows].