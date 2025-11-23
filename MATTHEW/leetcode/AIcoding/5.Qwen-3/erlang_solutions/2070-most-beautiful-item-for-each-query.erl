-module(most_beautiful_item_for_each_query).
-export([maximum_beauty/2]).

maximum_beauty(Items, Queries) ->
    SortedItems = lists:sort(fun({A, _}, {B, _}) -> A < B end, Items),
    MaxBeauty = maps:new(),
    MaxBeautyList = lists:foldl(fun({Price, Beauty}, Acc) ->
                                        maps:update_with(Price, fun(B) -> max(B, Beauty) end, Beauty, Acc)
                                end, MaxBeauty, SortedItems),
    SortedPrices = lists:usort([P || {P, _} <- SortedItems]),
    lists:map(fun(Query) -> find_max_beauty(Query, SortedPrices, MaxBeautyList) end, Queries).

find_max_beauty(Query, Prices, MaxBeauty) ->
    case lists:search(Query, Prices) of
        false ->
            case lists:splitwith(fun(P) -> P < Query end, Prices) of
                {[], _} -> 0;
                {Prefix, _} -> maps:get(lists:last(Prefix), MaxBeauty, 0)
            end;
        {Pos, _} -> maps:get(lists:nth(Pos, Prices), MaxBeauty, 0)
    end.