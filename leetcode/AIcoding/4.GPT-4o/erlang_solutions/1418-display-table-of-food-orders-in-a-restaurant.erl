-module(solution).
-export([display_table/1]).

display_table(Order) ->
    FoodOrders = lists:foldl(fun({_, _, Dish}) -> fun(Dish) -> [Dish | _] end end, [], Order),
    UniqueDishes = lists:usort(FoodOrders),
    Tables = lists:foldl(fun({Table, _, _}) -> fun(Table) -> [Table | _] end end, [], Order),
    UniqueTables = lists:usort(Tables),
    DisplayTable = [["Table"] ++ UniqueDishes] ++ lists:map(fun(Table) ->
        Row = [Table] ++ lists:map(fun(Dish) -> 
          case lists:filter(fun({T, _, D}) -> T =:= Table andalso D =:= Dish end, Order) of
              [] -> 0;
              [_ | _] -> 1
          end
        end, UniqueDishes),
        Row
    end, UniqueTables),
    DisplayTable.