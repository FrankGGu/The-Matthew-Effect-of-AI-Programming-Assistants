-spec minimum_deletions(S :: unicode:unicode_binary()) -> integer().
minimum_deletions(S) ->
    {A, B, Ans} = lists:foldl(fun
        ($a, {A, B, Ans}) -> {A + 1, B, Ans};
        ($b, {A, B, Ans}) -> {A, B + 1, min(Ans + 1, A)}
    end, {0, 0, 0}, S),
    Ans.