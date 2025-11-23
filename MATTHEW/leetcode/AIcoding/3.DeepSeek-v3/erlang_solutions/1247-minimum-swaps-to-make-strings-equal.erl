-spec minimum_swap(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary()) -> integer().
minimum_swap(S1, S2) ->
    {X, Y} = lists:foldl(fun
        ({C1, C2}, {XAcc, YAcc}) when C1 =:= $x, C2 =:= $y ->
            {XAcc + 1, YAcc};
        ({C1, C2}, {XAcc, YAcc}) when C1 =:= $y, C2 =:= $x ->
            {XAcc, YAcc + 1};
        (_, Acc) -> Acc
    end, {0, 0}, lists:zip(binary_to_list(S1), binary_to_list(S2))),
    case (X + Y) rem 2 of
        1 -> -1;
        _ -> (X + 1) div 2 + (Y + 1) div 2
    end.