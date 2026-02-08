-spec count_points(Points :: [[integer()]], Queries :: [[integer()]]) -> [integer()].
count_points(Points, Queries) ->
    lists:map(fun([Xj, Yj, Rj]) ->
        lists:foldl(fun([Xi, Yi], Acc) ->
            Dx = Xi - Xj,
            Dy = Yi - Yj,
            case Dx * Dx + Dy * Dy =< Rj * Rj of
                true -> Acc + 1;
                false -> Acc
            end
        end, 0, Points)
    end, Queries).