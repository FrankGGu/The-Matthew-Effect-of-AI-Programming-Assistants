-module(max_subarray_min_product).
-export([max_sum_min_product/1]).

max_sum_min_product(Nums) ->
    max_sum_min_product(Nums, 0).

max_sum_min_product(Nums, Mod) ->
    N = length(Nums),
    {Left, Right} = find_nearest_smaller(Nums, N),
    PrefixSum = calculate_prefix_sum(Nums, N),
    MaxProduct = calculate_max_product(Left, Right, PrefixSum, N, Nums, 0),
    MaxProduct rem 1000000007.

find_nearest_smaller(Nums, N) ->
    Left = lists:map(fun(_) -> 0 end, lists:seq(1, N)),
    Right = lists:map(fun(_) -> 0 end, lists:seq(1, N)),
    Stack = [],
    {LeftRes, RightRes} = find_nearest_smaller_helper(Nums, N, 1, Stack, Left, Right),
    {LeftRes, RightRes}.

find_nearest_smaller_helper(_Nums, N, I, Stack, Left, Right) when I > N ->
    {Left, Right};
find_nearest_smaller_helper(Nums, N, I, Stack, Left, Right) ->
    Num = lists:nth(I, Nums),
    {NewLeft, NewStack} = find_nearest_smaller_left(Nums, Num, I, Stack, Left),
    {NewRight, NewRightStack} = find_nearest_smaller_right(Nums, Num, I, NewStack, Right),
    find_nearest_smaller_helper(Nums, N, I + 1, NewRightStack, NewLeft, NewRight).

find_nearest_smaller_left(Nums, Num, I, Stack, Left) ->
    case Stack of
        [] ->
            {lists:nth(I, lists:nth(1, lists:zip(Left, lists:seq(1, length(Left))))), [{Num, I} | Stack]};
        [{TopNum, TopIndex} | _] when TopNum >= Num ->
            {NewLeft, NewStack} = find_nearest_smaller_left(Nums, Num, I, tl(Stack), Left),
            {NewLeft, [{Num, I} | NewStack]};
        _ ->
            LeftIndex = lists:nth(2, hd(Stack)),
            NewLeft = lists:replace(I, LeftIndex, Left),
            {NewLeft, [{Num, I} | Stack]}
    end.

find_nearest_smaller_right(Nums, Num, I, Stack, Right) ->
    case Stack of
        [] ->
            {NewRight, [{Num, I} | Stack]} = {lists:replace(I, I, Right), [{Num, I} | Stack]};
        [{TopNum, TopIndex} | _] ->
            {NewRight, [{Num, I} | Stack]} = {lists:replace(I, N, Right), [{Num, I} | Stack]}
    end.

calculate_prefix_sum(Nums, N) ->
    calculate_prefix_sum_helper(Nums, N, 1, [0]).

calculate_prefix_sum_helper(Nums, N, I, PrefixSum) when I > N ->
    PrefixSum;
calculate_prefix_sum_helper(Nums, N, I, PrefixSum) ->
    Num = lists:nth(I, Nums),
    NewPrefixSum = PrefixSum ++ [lists:last(PrefixSum) + Num],
    calculate_prefix_sum_helper(Nums, N, I + 1, NewPrefixSum).

calculate_max_product(Left, Right, PrefixSum, N, Nums, MaxProduct) ->
    calculate_max_product_helper(Left, Right, PrefixSum, N, Nums, 1, MaxProduct).

calculate_max_product_helper(Left, Right, PrefixSum, N, Nums, I, MaxProduct) when I > N ->
    MaxProduct;
calculate_max_product_helper(Left, Right, PrefixSum, N, Nums, I, MaxProduct) ->
    L = lists:nth(I, Left) + 1,
    R = lists:nth(I, Right) - 1,
    SubarraySum = get_subarray_sum(PrefixSum, L, R),
    MinVal = lists:nth(I, Nums),
    Product = SubarraySum * MinVal,
    NewMaxProduct = max(MaxProduct, Product),
    calculate_max_product_helper(Left, Right, PrefixSum, N, Nums, I + 1, NewMaxProduct).

get_subarray_sum(PrefixSum, L, R) ->
    lists:nth(R + 1, PrefixSum) - lists:nth(L, PrefixSum).