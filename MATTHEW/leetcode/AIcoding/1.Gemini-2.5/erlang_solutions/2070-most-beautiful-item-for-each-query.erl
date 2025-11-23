-module(solution).
-export([most_beautiful_item_for_each_query/2]).

most_beautiful_item_for_each_query(Items, Queries) ->
    SortedItems = lists:keysort(1, Items),
    ProcessedItems = build_processed_items(SortedItems, 0, []),

    IndexedQueries = lists:zip(Queries, lists:seq(0, length(Queries) - 1)),
    SortedIndexedQueries = lists:keysort(1, IndexedQueries),

    InitialAnswersArray = array:new([{size, length(Queries)}, {fixed, true}, {default, 0}]),

    FinalAnswersArray = process_queries_recursive(SortedIndexedQueries, ProcessedItems, 0, InitialAnswersArray),

    array:to_list(FinalAnswersArray).

build_processed_items([], _CurrentMaxBeauty, AccProcessedItems) ->
    lists:reverse(AccProcessedItems);
build_processed_items([[Price, Beauty] | Rest], CurrentMaxBeauty, AccProcessedItems) ->
    NewMaxBeauty = max(CurrentMaxBeauty, Beauty),
    build_processed_items(Rest, NewMaxBeauty, [[Price, NewMaxBeauty] | AccProcessedItems]).

process_queries_recursive([], _CurrentProcessedItemsTail, _CurrentMaxBeautyForItems, AnswersArray) ->
    AnswersArray;
process_queries_recursive([{Query, OriginalIdx} | RestQueries], CurrentProcessedItemsTail, CurrentMaxBeautyForItems, AnswersArray) ->
    {NewProcessedItemsTail, NewCurrentMaxBeautyForItems} =
        advance_processed_items(CurrentProcessedItemsTail, CurrentMaxBeautyForItems, Query),

    UpdatedAnswersArray = array:set(OriginalIdx, NewCurrentMaxBeautyForItems, AnswersArray),

    process_queries_recursive(RestQueries, NewProcessedItemsTail, NewCurrentMaxBeautyForItems, UpdatedAnswersArray).

advance_processed_items([], CurrentMaxBeauty, _Query) ->
    {[], CurrentMaxBeauty};
advance_processed_items([[Price, MaxBeautyAtPrice] | RestItems], _CurrentMaxBeauty, Query) when Price =< Query ->
    advance_processed_items(RestItems, MaxBeautyAtPrice, Query);
advance_processed_items(RemainingItems, CurrentMaxBeauty, _Query) ->
    {RemainingItems, CurrentMaxBeauty}.