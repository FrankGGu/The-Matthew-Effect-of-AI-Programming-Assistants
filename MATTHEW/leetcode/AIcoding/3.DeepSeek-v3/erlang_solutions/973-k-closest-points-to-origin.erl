-spec k_closest(Points :: [[integer()]], K :: integer()) -> [[integer()]].
k_closest(Points, K) ->
    Distances = lists:map(fun([X, Y]) -> {X * X + Y * Y, [X, Y]} end, Points),
    Sorted = lists:sort(fun({D1, _}, {D2, _}) -> D1 =< D2 end, Distances),
    TopK = lists:sublist(Sorted, K),
    lists:map(fun({_, Point}) -> Point end, TopK).