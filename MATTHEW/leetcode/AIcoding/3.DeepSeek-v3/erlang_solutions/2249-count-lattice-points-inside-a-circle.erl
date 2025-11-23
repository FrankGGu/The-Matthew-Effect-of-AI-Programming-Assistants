-spec count_lattice_points(Circles :: [[integer()]]) -> integer().
count_lattice_points(Circles) ->
    Points = sets:new(),
    lists:foldl(
        fun([X, Y, R], Acc) ->
            lists:foldl(
                fun(I, InnerAcc) ->
                    lists:foldl(
                        fun(J, InnerInnerAcc) ->
                            case (I - X) * (I - X) + (J - Y) * (J - Y) =< R * R of
                                true -> sets:add_element({I, J}, InnerInnerAcc);
                                false -> InnerInnerAcc
                            end
                        end,
                        InnerAcc,
                        lists:seq(Y - R, Y + R)
                    )
                end,
                Acc,
                lists:seq(X - R, X + R)
            )
        end,
        Points,
        Circles
    ),
    sets:size(Points).