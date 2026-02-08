-spec number_of_boomerangs(Points :: [[integer()]]) -> integer().
number_of_boomerangs(Points) ->
    lists:foldl(fun(P, Acc) ->
        Distances = lists:foldl(fun(Q, Dists) ->
            Dx = lists:nth(1, P) - lists:nth(1, Q),
            Dy = lists:nth(2, P) - lists:nth(2, Q),
            Distance = Dx * Dx + Dy * Dy,
            maps:update_with(Distance, fun(V) -> V + 1 end, 1, Dists)
        end, #{}, Points),
        maps:fold(fun(_, V, Sum) -> Sum + V * (V - 1) end, Acc, Distances)
    end, 0, Points).