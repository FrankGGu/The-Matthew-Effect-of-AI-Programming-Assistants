-spec purchase_plan(Nums :: [integer()], Target :: integer()) -> integer().
purchase_plan(Nums, Target) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    Count = count_pairs(Sorted, Target, 0, Len - 1, 0),
    Count rem 1000000007.

count_pairs(_, _, Left, Right, Acc) when Left >= Right ->
    Acc;
count_pairs(Sorted, Target, Left, Right, Acc) ->
    case lists:nth(Left + 1, Sorted) + lists:nth(Right + 1, Sorted) =< Target of
        true ->
            NewAcc = (Acc + (Right - Left)) rem 1000000007,
            count_pairs(Sorted, Target, Left + 1, Right, NewAcc);
        false ->
            count_pairs(Sorted, Target, Left, Right - 1, Acc)
    end.