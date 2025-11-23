-module(display_table).
-export([display_table/1]).

display_table(Orders) ->
  {Headers, Table} = process_orders(Orders),
  [Headers | Table].

process_orders(Orders) ->
  {Items, Tables} = lists:foldl(
    fun([_, TableStr, Item], {ItemsAcc, TablesAcc}) ->
      Table = list_to_integer(TableStr),
      Items1 = sets:add_element(Item, ItemsAcc),
      Tables1 = maps:update_with(
        Table,
        fun(Map) ->
          maps:update_with(
            Item,
            fun(Count) -> Count + 1 end,
            Map,
            1
          )
        end,
        TablesAcc,
        #{Item => 1}
      ),
      {Items1, Tables1}
    end,
    {sets:new(), #{}},
    Orders
  ),
  SortedItems = lists:sort(sets:to_list(Items)),
  Headers = ["Table" | SortedItems],
  SortedTables = lists:sort(maps:keys(Tables)),
  Table = lists:map(
    fun(TableNum) ->
      Row = lists:foldl(
        fun(Item, Acc) ->
          case maps:is_key(Item, maps:get(TableNum, Tables, #{})) of
            true ->
              [integer_to_list(maps:get(Item, maps:get(TableNum, Tables))) | Acc];
            false ->
              ["0" | Acc]
          end
        end,
        [integer_to_list(TableNum)],
        SortedItems
      ),
      lists:reverse(Row)
    end,
    SortedTables
  ),
  {Headers, Table}.