-spec maximize_greatness(Nums :: [integer()]) -> integer().
maximize_greatness(Nums) ->
    Sorted = lists:sort(Nums),
    {Count, _} = lists:foldl(fun(N, {C, Rest}) ->
        case Rest of
            [] -> {C, []};
            [H | T] when H > N -> {C + 1, T};
            [H | T] -> {C, T ++ [H]}
        end
    end, {0, Sorted}, Sorted),
    Count.