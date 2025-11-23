-module(seasonal_sales_analysis).
-export([sales_by_season/1]).

sales_by_season(Sales) ->
    SalesMap = maps:from_list(Sales),
    Months = maps:keys(SalesMap),
    SortedMonths = lists:sort(Months),
    SeasonSales = season_sales(SortedMonths, SalesMap, #{}),
    maps:to_list(SeasonSales).

season_sales([], _SalesMap, Acc) ->
    Acc;
season_sales([Month | Rest], SalesMap, Acc) ->
    Season = get_season(Month),
    Sale = maps:get(Month, SalesMap),
    case maps:find(Season, Acc) of
        {ok, Total} ->
            NewAcc = maps:put(Season, Total + Sale, Acc),
            season_sales(Rest, SalesMap, NewAcc);
        error ->
            NewAcc = maps:put(Season, Sale, Acc),
            season_sales(Rest, SalesMap, NewAcc)
    end.

get_season(1) -> winter;
get_season(2) -> winter;
get_season(3) -> spring;
get_season(4) -> spring;
get_season(5) -> spring;
get_season(6) -> summer;
get_season(7) -> summer;
get_season(8) -> summer;
get_season(9) -> fall;
get_season(10) -> fall;
get_season(11) -> fall;
get_season(12) -> winter.