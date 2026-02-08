-spec max_num_of_marked_indices(Nums :: [integer()]) -> integer().
max_num_of_marked_indices(Nums) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Half = N div 2,
    {Count, I, J} = lists:foldl(
        fun(_, {C, I1, J1}) when J1 >= N ->
                {C, I1, J1};
            (_, {C, I1, J1}) when I1 >= Half ->
                {C, I1, J1};
            (_, {C, I1, J1}) ->
                case lists:nth(I1 + 1, Sorted) * 2 =< lists:nth(J1 + 1, Sorted) of
                    true -> {C + 1, I1 + 1, J1 + 1};
                    false -> {C, I1, J1 + 1}
                end
        end,
        {0, 0, Half},
        lists:seq(1, N)
    ),
    Count * 2.