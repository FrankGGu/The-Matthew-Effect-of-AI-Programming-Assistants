-spec minimum_steps(Balls :: unicode:unicode_binary()) -> integer().
minimum_steps(Balls) ->
    {_, Steps} = lists:foldl(fun
        ($0, {Count, Acc}) -> {Count + 1, Acc};
        ($1, {Count, Acc}) -> {Count, Acc + Count}
    end, {0, 0}, Balls),
    Steps.