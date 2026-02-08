-spec max_points(Points :: [[integer()]]) -> integer().
max_points(Points) ->
    case Points of
        [] -> 0;
        [_] -> 1;
        _ ->
            lists:max([max_points_for_point(Points, I) || I <- lists:seq(0, length(Points) - 1)])
    end.

max_points_for_point(Points, I) ->
    {X1, Y1} = {lists:nth(1, lists:nth(I + 1, Points)), lists:nth(2, lists:nth(I + 1, Points))},
    Slopes = lists:foldl(fun(J, Acc) ->
        if
            I =:= J -> Acc;
            true ->
                {X2, Y2} = {lists:nth(1, lists:nth(J + 1, Points)), lists:nth(2, lists:nth(J + 1, Points))},
                DX = X2 - X1,
                DY = Y2 - Y1,
                GCD = gcd(DX, DY),
                Slope = {DX div GCD, DY div GCD},
                maps:update_with(Slope, fun(V) -> V + 1 end, 1, Acc)
        end
    end, #{}, lists:seq(0, length(Points) - 1)),
    case maps:size(Slopes) of
        0 -> 1;
        _ -> lists:max(maps:values(Slopes)) + 1
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).