-module(solution).
-export([display_table/1]).

display_table(Orders) ->
    {FoodItemsSet, TableNumbersSet, Counts} = lists:foldl(
        fun([_Customer, TableStr, FoodItem], {AccFoodItems, AccTableNumbers, AccCounts}) ->
            TableNum = list_to_integer(TableStr),
            NewFoodItems = sets:add_element(FoodItem, AccFoodItems),
            NewTableNumbers = sets:add_element(TableNum, AccTableNumbers),

            TableFoodCounts = maps:get(TableNum, AccCounts, #{}),
            CurrentCount = maps:get(FoodItem, TableFoodCounts, 0),
            NewTableFoodCounts = maps:put(FoodItem, CurrentCount + 1, TableFoodCounts),
            NewCounts = maps:put(TableNum, NewTableFoodCounts, AccCounts),
            {NewFoodItems, NewTableNumbers, NewCounts}
        end,
        {sets:new(), sets:new(), #{}},
        Orders
    ),

    SortedFoodItems = lists:sort(sets:to_list(FoodItemsSet)),
    SortedTableNumbers = lists:sort(sets:to_list(TableNumbersSet)),

    Header = ["Table" | SortedFoodItems],

    DataRows = lists:map(
        fun(TableNum) ->
            TableRowStart = [integer_to_list(TableNum)],
            FoodCountsForTable = maps:get(TableNum, Counts, #{}),
            FoodCountsStrings = lists:map(
                fun(FoodItem) ->
                    integer_to_list(maps:get(FoodItem, FoodCountsForTable, 0))
                end,
                SortedFoodItems
            ),
            TableRowStart ++ FoodCountsStrings
        end,
        SortedTableNumbers
    ),

    [Header | DataRows].