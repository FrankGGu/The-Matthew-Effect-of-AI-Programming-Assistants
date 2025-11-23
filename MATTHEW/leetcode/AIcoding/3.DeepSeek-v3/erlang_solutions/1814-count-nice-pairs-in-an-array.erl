-spec count_nice_pairs(Nums :: [integer()]) -> integer().
count_nice_pairs(Nums) ->
    Rev = fun(N) -> list_to_integer(lists:reverse(integer_to_list(N))) end,
    Pairs = lists:foldl(
        fun(N, {Count, Map}) ->
            Key = N - Rev(N),
            case maps:get(Key, Map, 0) of
                V when is_integer(V) ->
                    NewCount = (Count + V) rem 1000000007,
                    NewMap = maps:put(Key, V + 1, Map),
                    {NewCount, NewMap};
                _ ->
                    {Count, Map}
            end
        end,
        {0, #{}},
        Nums
    ),
    element(1, Pairs).