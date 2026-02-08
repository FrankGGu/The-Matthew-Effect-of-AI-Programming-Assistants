-spec nearest_valid_point(X :: integer(), Y :: integer(), Points :: [[integer()]]) -> integer().
nearest_valid_point(X, Y, Points) ->
    ValidPoints = lists:filter(fun([Px, Py]) -> (Px == X) or (Py == Y) end, Points),
    case ValidPoints of
        [] -> -1;
        _ ->
            {MinIndex, _} = lists:foldl(
                fun([Px, Py], {Index, MinDist}) ->
                    Dist = abs(Px - X) + abs(Py - Y),
                    if
                        Dist < MinDist -> {Index + 1, Dist};
                        true -> {Index + 1, MinDist}
                    end
                end,
                {0, abs(lists:nth(1, hd(ValidPoints)) - X) + abs(lists:nth(2, hd(ValidPoints)) - Y)},
                ValidPoints
            ),
            MinIndex
    end.