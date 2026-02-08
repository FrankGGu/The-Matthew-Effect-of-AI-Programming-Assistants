-spec is_robot_bounded(Instructions :: unicode:unicode_binary()) -> boolean().
is_robot_bounded(Instructions) ->
    Dir = [[0, 1], [1, 0], [0, -1], [-1, 0]],
    {X, Y, D} = lists:foldl(fun
        ($G, {X0, Y0, D0}) ->
            [Dx, Dy] = lists:nth(D0 + 1, Dir),
            {X0 + Dx, Y0 + Dy, D0};
        ($L, {X0, Y0, D0}) ->
            {X0, Y0, (D0 + 3) rem 4};
        ($R, {X0, Y0, D0}) ->
            {X0, Y0, (D0 + 1) rem 4}
    end, {0, 0, 0}, binary_to_list(Instructions)),
    (X =:= 0 andalso Y =:= 0) orelse (D rem 4 =/= 0).