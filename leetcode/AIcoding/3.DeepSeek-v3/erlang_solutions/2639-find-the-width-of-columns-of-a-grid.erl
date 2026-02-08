-spec max_width_of_vertical_area([[integer()]]) -> integer().
max_width_of_vertical_area(Points) ->
    Sorted = lists:sort([X || [X, _Y] <- Points]),
    lists:max([B - A || {A, B} <- lists:zip(Sorted, tl(Sorted))]).