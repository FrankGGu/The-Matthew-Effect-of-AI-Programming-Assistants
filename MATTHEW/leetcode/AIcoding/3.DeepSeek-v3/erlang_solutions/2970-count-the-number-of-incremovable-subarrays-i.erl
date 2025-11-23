-spec count_incremovable_subarrays(Nums :: [integer()]) -> integer().
count_incremovable_subarrays(Nums) ->
    N = length(Nums),
    Count = 0,
    count_subarrays(Nums, N, Count).

count_subarrays(_, 0, Count) -> Count;
count_subarrays(Nums, Len, Count) ->
    NewCount = lists:foldl(fun(Start, Acc) ->
        End = Start + Len - 1,
        if
            End >= length(Nums) -> Acc;
            true ->
                Subarray = lists:sublist(Nums, Start + 1, Len),
                case is_increasing(Subarray) of
                    true -> Acc + 1;
                    false -> Acc
                end
        end
    end, Count, lists:seq(0, length(Nums) - Len)),
    count_subarrays(Nums, Len - 1, NewCount).

is_increasing([_]) -> true;
is_increasing([X, Y | Rest]) ->
    if
        X < Y -> is_increasing([Y | Rest]);
        true -> false
    end.