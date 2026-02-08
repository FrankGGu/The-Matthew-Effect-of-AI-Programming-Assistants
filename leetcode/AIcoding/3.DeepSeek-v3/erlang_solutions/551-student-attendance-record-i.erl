-spec check_record(S :: unicode:unicode_binary()) -> boolean().
check_record(S) ->
    lists:foldl(fun
        ($A, {A, L}) when A >= 1 -> {2, 0};
        ($A, {A, L}) -> {A + 1, 0};
        ($L, {A, L}) when L >= 2 -> {A, 3};
        ($L, {A, L}) -> {A, L + 1};
        (_, {A, L}) -> {A, 0}
    end, {0, 0}, binary_to_list(S)),
    {A, L} = lists:foldl(fun
        ($A, {A, L}) when A >= 1 -> {2, 0};
        ($A, {A, L}) -> {A + 1, 0};
        ($L, {A, L}) when L >= 2 -> {A, 3};
        ($L, {A, L}) -> {A, L + 1};
        (_, {A, L}) -> {A, 0}
    end, {0, 0}, binary_to_list(S)),
    A < 2 andalso L < 3.