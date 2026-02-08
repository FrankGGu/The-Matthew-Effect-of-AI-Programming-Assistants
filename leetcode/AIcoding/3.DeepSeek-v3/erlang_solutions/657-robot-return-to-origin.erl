-spec judge_circle(Moves :: unicode:unicode_binary()) -> boolean().
judge_circle(Moves) ->
    lists:foldl(fun
        ($U, {X, Y}) -> {X, Y + 1};
        ($D, {X, Y}) -> {X, Y - 1};
        ($L, {X, Y}) -> {X - 1, Y};
        ($R, {X, Y}) -> {X + 1, Y}
    end, {0, 0}, binary_to_list(Moves)) == {0, 0}.