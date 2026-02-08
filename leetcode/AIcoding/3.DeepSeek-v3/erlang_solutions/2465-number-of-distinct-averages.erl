-spec distinct_averages(Nums :: [integer()]) -> integer().
distinct_averages(Nums) ->
    Sorted = lists:sort(Nums),
    distinct_averages(Sorted, sets:new()).

distinct_averages([], Set) ->
    sets:size(Set);
distinct_averages([Min | Rest], Set) ->
    [Max | NewRest] = lists:reverse(Rest),
    Avg = (Min + Max) / 2,
    NewSet = sets:add_element(Avg, Set),
    distinct_averages(lists:reverse(NewRest), NewSet).