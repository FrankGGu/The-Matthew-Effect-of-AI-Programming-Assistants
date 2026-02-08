-spec minimal_k_sum(Nums :: [integer()], K :: integer()) -> integer().
minimal_k_sum(Nums, K) ->
    Sorted = lists:sort(Nums),
    minimal_k_sum(Sorted, K, 1, 0).

minimal_k_sum(_, 0, _, Sum) -> Sum;
minimal_k_sum([], K, Next, Sum) ->
    Sum + (Next + Next + K - 1) * K div 2;
minimal_k_sum([H | T], K, Next, Sum) when H > Next ->
    Count = min(H - Next, K),
    NewSum = Sum + (Next + Next + Count - 1) * Count div 2,
    NewK = K - Count,
    minimal_k_sum(T, NewK, Next + Count, NewSum);
minimal_k_sum([H | T], K, Next, Sum) when H == Next ->
    minimal_k_sum(T, K, Next + 1, Sum);
minimal_k_sum([_ | T], K, Next, Sum) ->
    minimal_k_sum(T, K, Next, Sum).