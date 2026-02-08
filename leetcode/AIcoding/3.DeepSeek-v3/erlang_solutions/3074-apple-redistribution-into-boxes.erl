-spec min_apple_boxes(Apple :: [integer()], Capacity :: [integer()]) -> integer().
min_apple_boxes(Apple, Capacity) ->
    TotalApples = lists:sum(Apple),
    SortedCapacity = lists:reverse(lists:sort(Capacity)),
    count_boxes(SortedCapacity, TotalApples, 0).

count_boxes([], _, Count) -> Count;
count_boxes([Cap | Rest], ApplesLeft, Count) ->
    if
        ApplesLeft =< 0 -> Count;
        true ->
            NewApplesLeft = ApplesLeft - Cap,
            count_boxes(Rest, NewApplesLeft, Count + 1)
    end.