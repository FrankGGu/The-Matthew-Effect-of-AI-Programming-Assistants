-spec furthest_distance_from_origin(Moves :: unicode:unicode_binary()) -> integer().
furthest_distance_from_origin(Moves) ->
    L = binary_to_list(Moves),
    {Left, Right, Underscore} = lists:foldl(fun
        ($L, {L, R, U}) -> {L + 1, R, U};
        ($R, {L, R, U}) -> {L, R + 1, U};
        ($_, {L, R, U}) -> {L, R, U + 1}
    end, {0, 0, 0}, L),
    abs(Left - Right) + Underscore.