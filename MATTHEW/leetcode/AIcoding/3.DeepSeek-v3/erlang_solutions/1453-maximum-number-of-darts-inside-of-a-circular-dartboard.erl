-spec num_points(Points :: [[integer()]], R :: integer()) -> integer().
num_points(Points, R) ->
    case Points of
        [] -> 0;
        _ ->
            Max = lists:foldl(fun(_, Acc) -> max(0, Acc) end, 0, Points),
            lists:max([count_points(Points, X, Y, R) || X <- get_x_coords(Points), Y <- get_y_coords(Points)])
    end.

get_x_coords(Points) ->
    lists:usort([X || [X, _] <- Points]).

get_y_coords(Points) ->
    lists:usort([Y || [_, Y] <- Points]).

count_points(Points, X, Y, R) ->
    lists:foldl(fun([Px, Py], Acc) ->
                    case (Px - X) * (Px - X) + (Py - Y) * (Py - Y) =< R * R of
                        true -> Acc + 1;
                        false -> Acc
                    end
                end, 0, Points).