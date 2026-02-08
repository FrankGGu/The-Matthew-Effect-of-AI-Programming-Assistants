-spec minimum_sum(Num :: integer()) -> integer().
minimum_sum(Num) ->
    Digits = [Num div 1000 rem 10, Num div 100 rem 10, Num div 10 rem 10, Num rem 10],
    Sorted = lists:sort(Digits),
    (lists:nth(1, Sorted) + lists:nth(2, Sorted)) * 10 + lists:nth(3, Sorted) + lists:nth(4, Sorted).