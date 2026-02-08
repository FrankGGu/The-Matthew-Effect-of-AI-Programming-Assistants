-spec most_frequent_even(Nums :: [integer()]) -> integer().
most_frequent_even(Nums) ->
    EvenFreq = lists:foldl(
        fun(N, Acc) ->
            case N rem 2 of
                0 -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc);
                _ -> Acc
            end
        end,
        maps:new(),
        Nums
    ),
    case maps:size(EvenFreq) of
        0 -> -1;
        _ ->
            {MaxFreq, MinNum} = maps:fold(
                fun(N, Freq, {CurrentMax, CurrentMin}) ->
                    if
                        Freq > CurrentMax -> {Freq, N};
                        Freq == CurrentMax andalso N < CurrentMin -> {Freq, N};
                        true -> {CurrentMax, CurrentMin}
                    end
                end,
                {-1, -1},
                EvenFreq
            ),
            MinNum
    end.