-module(solution).
-export([solve/1]).

solve(Sales) ->
    InitialSales = #{winter => 0, spring => 0, summer => 0, autumn => 0},
    lists:foldl(fun({_ProductId, DateString, Quantity}, Acc) ->
                        Month = get_month(DateString),
                        Season = get_season(Month),
                        maps:update_with(Season, fun(CurrentTotal) -> CurrentTotal + Quantity end, Quantity, Acc)
                end, InitialSales, Sales).

get_month(DateString) ->
    [_, MonthStr, _] = string:tokens(DateString, "-"),
    list_to_integer(MonthStr).

get_season(Month) when Month >= 1 andalso Month =< 2; Month == 12 -> winter;
get_season(Month) when Month >= 3 andalso Month =< 5 -> spring;
get_season(Month) when Month >= 6 andalso Month =< 8 -> summer;
get_season(Month) when Month >= 9 andalso Month =< 11 -> autumn.