-spec find_unique_binary_string(Nums :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
find_unique_binary_string(Nums) ->
    N = length(Nums),
    lists:foldl(
        fun(_, Acc) ->
            Bin = << <<(rand:uniform(2) - 1 + $0)>> || _ <- lists:seq(1, N) >>,
            case lists:member(Bin, Nums) of
                false -> Bin;
                true -> Acc
            end
        end,
        <<>>,
        lists:seq(1, 1000)
    ).