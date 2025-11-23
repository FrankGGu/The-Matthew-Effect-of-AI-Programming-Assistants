-spec count_largest_group(N :: integer()) -> integer().
count_largest_group(N) ->
    Sums = lists:foldl(
        fun(I, Acc) ->
            Sum = lists:foldl(
                fun(D, S) -> S + D - $0 end,
                0,
                integer_to_list(I)
            ),
            maps:update_with(Sum, fun(V) -> V + 1 end, 1, Acc)
        end,
        maps:new(),
        lists:seq(1, N)
    ),
    Values = maps:values(Sums),
    Max = lists:max(Values),
    length([V || V <- Values, V == Max]).