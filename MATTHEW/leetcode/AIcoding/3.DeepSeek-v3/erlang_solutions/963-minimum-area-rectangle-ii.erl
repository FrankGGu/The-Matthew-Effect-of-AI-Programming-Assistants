-spec min_area_free_rect(Points :: [[integer()]]) -> float().
min_area_free_rect(Points) ->
    PointsSet = sets:from_list([{X, Y} || [X, Y] <- Points]),
    N = length(Points),
    MinArea = lists:foldl(
        fun(I, CurrentMin) ->
            lists:foldl(
                fun(J, AccMin) ->
                    lists:foldl(
                        fun(K, InnerMin) ->
                            [X1, Y1] = lists:nth(I, Points),
                            [X2, Y2] = lists:nth(J, Points),
                            [X3, Y3] = lists:nth(K, Points),
                            Dx1 = X2 - X1,
                            Dy1 = Y2 - Y1,
                            Dx2 = X3 - X1,
                            Dy2 = Y3 - Y1,
                            case (Dx1 * Dx2 + Dy1 * Dy2) == 0 of
                                true ->
                                    X4 = X2 + X3 - X1,
                                    Y4 = Y2 + Y3 - Y1,
                                    case sets:is_element({X4, Y4}, PointsSet) of
                                        true ->
                                            Area = math:sqrt(Dx1 * Dx1 + Dy1 * Dy1) * math:sqrt(Dx2 * Dx2 + Dy2 * Dy2),
                                            case Area < InnerMin of
                                                true -> Area;
                                                false -> InnerMin
                                            end;
                                        false -> InnerMin
                                    end;
                                false -> InnerMin
                            end
                        end,
                        AccMin,
                        lists:seq(1, N)
                end,
                CurrentMin,
                lists:seq(1, N)
            )
        end,
        infinity,
        lists:seq(1, N)
    ),
    case MinArea == infinity of
        true -> 0.0;
        false -> MinArea
    end.