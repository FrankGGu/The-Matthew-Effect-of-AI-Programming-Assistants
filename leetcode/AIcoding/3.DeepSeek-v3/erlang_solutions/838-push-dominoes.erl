-spec push_dominoes(Dominoes :: unicode:unicode_binary()) -> unicode:unicode_binary().
push_dominoes(Dominoes) ->
    List = binary_to_list(Dominoes),
    N = length(List),
    Forces = lists:duplicate(N, 0),
    {Forces1, _} = lists:foldl(fun
        ($R, {Fs, F}) -> {Fs, 1};
        ($L, {Fs, F}) -> {Fs, 0};
        ($., {Fs, F}) when F > 0 -> {[F | tl(Fs)], F + 1};
        (_, {Fs, F}) -> {[0 | tl(Fs)], 0}
    end, {Forces, 0}, List),
    {Forces2, _} = lists:foldr(fun
        ($L, {Fs, F}) -> {Fs, -1};
        ($R, {Fs, F}) -> {Fs, 0};
        ($., {Fs, F}) when F < 0 -> {[F | tl(Fs)], F - 1};
        (_, {Fs, F}) -> {[0 | tl(Fs)], 0}
    end, {Forces, 0}, List),
    Result = lists:map(fun
        {F1, F2} when F1 + F2 > 0 -> $R;
        {F1, F2} when F1 + F2 < 0 -> $L;
        _ -> $.
    end, lists:zip(lists:reverse(Forces1), lists:reverse(Forces2))),
    list_to_binary(Result).