-spec num_times_prefix_aligned(Flips :: [integer()]) -> integer().
num_times_prefix_aligned(Flips) ->
    {_, Res} = lists:foldl(fun(Flip, {Max, Count, Acc}) ->
        NewMax = max(Max, Flip),
        NewAcc = Acc + 1,
        case NewMax == NewAcc of
            true -> {NewMax, Count + 1, NewAcc};
            false -> {NewMax, Count, NewAcc}
        end
    end, {0, 0, 0}, Flips),
    Res.