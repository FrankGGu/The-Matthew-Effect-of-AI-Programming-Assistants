-spec count_subarrays(Nums :: [integer()], K :: integer()) -> integer().
count_subarrays(Nums, K) ->
    count_subarrays(Nums, K, 0, 0, 0, 0).

count_subarrays([], _K, _Sum, _Product, Left, Count) ->
    Count;
count_subarrays([Num | Rest], K, Sum, Product, Left, Count) ->
    NewSum = Sum + Num,
    NewProduct = (Product + Sum + 1) * Num,
    case NewProduct < K of
        true ->
            NewCount = Count + (length(Rest) + 1),
            count_subarrays(Rest, K, NewSum, NewProduct, Left, NewCount);
        false ->
            {NewLeft, NewSum1, NewProduct1} = adjust_left(Nums, Left, NewSum, NewProduct, Num, K),
            NewCount = Count + (length(Rest) + 1 - (NewLeft - Left)),
            count_subarrays(Rest, K, NewSum1, NewProduct1, NewLeft, NewCount)
    end.

adjust_left(Nums, Left, Sum, Product, Num, K) ->
    case Product >= K of
        true ->
            case Left < length(Nums) of
                true ->
                    Head = lists:nth(Left + 1, Nums),
                    NewSum = Sum - Head,
                    NewProduct = (Product - (Sum - NewSum) * (NewSum + 1) div (Head + 1),
                    adjust_left(Nums, Left + 1, NewSum, NewProduct, Num, K);
                false ->
                    {Left, Sum, Product}
            end;
        false ->
            {Left, Sum, Product}
    end.