-spec maximum_bags(Capacity :: [integer()], Rocks :: [integer()], AdditionalRocks :: integer()) -> integer().
maximum_bags(Capacity, Rocks, AdditionalRocks) ->
    Diffs = lists:zipwith(fun(C, R) -> C - R end, Capacity, Rocks),
    SortedDiffs = lists:sort(Diffs),
    count_bags(SortedDiffs, AdditionalRocks, 0).

count_bags([], _, Count) -> Count;
count_bags([Diff | Rest], AdditionalRocks, Count) ->
    case AdditionalRocks >= Diff of
        true -> count_bags(Rest, AdditionalRocks - Diff, Count + 1);
        false -> Count
    end.