-spec sum_odd_length_subarrays(Arr :: [integer()]) -> integer().
sum_odd_length_subarrays(Arr) ->
    N = length(Arr),
    Sum = 0,
    lists:foldl(
        fun(I, Acc1) ->
            lists:foldl(
                fun(J, Acc2) ->
                    Len = J - I + 1,
                    case Len rem 2 of
                        1 ->
                            Sub = lists:sublist(Arr, I + 1, Len),
                            Acc2 + lists:sum(Sub);
                        0 ->
                            Acc2
                    end
                end,
                Acc1,
                lists:seq(I, N - 1)
            )
        end,
        Sum,
        lists:seq(0, N - 1)
    ).