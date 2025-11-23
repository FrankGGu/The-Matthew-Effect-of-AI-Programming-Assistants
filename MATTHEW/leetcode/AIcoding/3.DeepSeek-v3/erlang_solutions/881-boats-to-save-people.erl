-spec num_rescue_boats(People :: [integer()], Limit :: integer()) -> integer().
num_rescue_boats(People, Limit) ->
    Sorted = lists:sort(People),
    count_boats(Sorted, Limit, 0).

count_boats([], _Limit, Count) -> Count;
count_boats([P], _Limit, Count) -> Count + 1;
count_boats([H | T], Limit, Count) ->
    case lists:last(T) of
        Last when H + Last =< Limit ->
            count_boats(lists:droplast(T), Limit, Count + 1);
        _ ->
            count_boats(T, Limit, Count + 1)
    end.