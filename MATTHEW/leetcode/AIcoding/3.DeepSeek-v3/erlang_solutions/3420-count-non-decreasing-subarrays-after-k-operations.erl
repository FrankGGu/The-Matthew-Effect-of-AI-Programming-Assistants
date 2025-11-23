-spec count_subarrays(Nums :: [integer()], K :: integer()) -> integer().
count_subarrays(Nums, K) ->
    {Sum, _} = lists:foldl(fun(_, {Acc, _}) -> {Acc + 1, 0} end, {0, 0}, lists:seq(1, length(Nums))),
    count_subarrays(Nums, K, Sum).

count_subarrays(_, 0, Sum) -> Sum;
count_subarrays(Nums, K, Sum) ->
    NewNums = lists:map(fun(X) -> X + 1 end, Nums),
    {NewSum, _} = lists:foldl(fun(_, {Acc, _}) -> {Acc + 1, 0} end, {0, 0}, lists:seq(1, length(NewNums))),
    count_subarrays(NewNums, K - 1, Sum + NewSum).