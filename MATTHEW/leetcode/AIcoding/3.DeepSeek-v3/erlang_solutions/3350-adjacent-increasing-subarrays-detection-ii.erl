-spec count_subarrays(Nums :: [integer()]) -> integer().
count_subarrays(Nums) ->
    N = length(Nums),
    Count = lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, InnerAcc) ->
                    case is_increasing(lists:sublist(Nums, I, J - I + 1)) of
                        true -> InnerAcc + 1;
                        false -> InnerAcc
                    end
                end,
                Acc,
                lists:seq(I, N)
            )
        end,
        0,
        lists:seq(1, N)
    ),
    Count.

is_increasing([_]) -> true;
is_increasing([X, Y | Rest]) when X < Y -> is_increasing([Y | Rest]);
is_increasing(_) -> false.