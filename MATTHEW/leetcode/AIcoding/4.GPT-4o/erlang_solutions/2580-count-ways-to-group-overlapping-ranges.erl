-module(solution).
-export([count_ways/1]).

count_ways(Ranges) ->
    Sorted = lists:sort(fun({Start1, _}, {Start2, _}) -> Start1 < Start2 end, Ranges),
    count_ways(Sorted, 0).

count_ways([], Count) -> 
    Count + 1;
count_ways([{Start, End} | Rest], Count) ->
    {Count1, Rest1} = count_overlaps(Rest, End, 1),
    count_ways(Rest1, Count + Count1).

count_overlaps([], _, Count) -> {Count, []};
count_overlaps([{Start, End} | Rest], LastEnd, Count) when Start <= LastEnd ->
    count_overlaps(Rest, lists:max(LastEnd, End), Count + 1);
count_overlaps(Rest, LastEnd, Count) ->
    {Count, Rest}.