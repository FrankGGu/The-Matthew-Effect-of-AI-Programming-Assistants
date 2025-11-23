-spec num_times_all_blue(flips :: [integer()]) -> integer().
num_times_all_blue(Flips) ->
    {Count, Max, _} = lists:foldl(fun(Flip, {Cnt, CurrentMax, Index}) ->
        NewMax = max(CurrentMax, Flip),
        case NewMax == Index + 1 of
            true -> {Cnt + 1, NewMax, Index + 1};
            false -> {Cnt, NewMax, Index + 1}
        end
    end, {0, 0, 0}, Flips),
    Count.