-module(most_beautiful_item_for_each_query).
-export([most_beautiful_item_for_each_query/2]).

most_beautiful_item_for_each_query(Items, Queries) ->
    SortedItems = lists:sort(Items),
    [find_max_beauty(SortedItems, Q) || Q <- Queries].

find_max_beauty(Items, Query) ->
    find_max_beauty(Items, Query, 0).

find_max_beauty([], _, MaxBeauty) ->
    MaxBeauty;
find_max_beauty([[Price, Beauty] | Rest], Query, MaxBeauty) ->
    if
        Price =< Query ->
            NewMaxBeauty = max(MaxBeauty, Beauty),
            find_max_beauty(Rest, Query, NewMaxBeauty);
        true ->
            MaxBeauty
    end.