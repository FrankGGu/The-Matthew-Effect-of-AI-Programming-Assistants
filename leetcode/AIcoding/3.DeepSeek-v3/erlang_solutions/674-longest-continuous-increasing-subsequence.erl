-spec find_length_of_lcis(Nums :: [integer()]) -> integer().
find_length_of_lcis(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            {MaxLen, CurrLen} = lists:foldl(
                fun(N, {Max, Curr, Prev}) ->
                    if
                        N > Prev -> {max(Max, Curr + 1), Curr + 1, N};
                        true -> {max(Max, 1), 1, N}
                    end
                end,
                {1, 1, hd(Nums)},
                tl(Nums)
            ),
            MaxLen
    end.