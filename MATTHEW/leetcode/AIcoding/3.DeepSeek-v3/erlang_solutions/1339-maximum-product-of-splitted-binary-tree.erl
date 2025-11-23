-spec max_product(TreeNode :: #tree_node{} | null) -> integer().
max_product(null) -> 0;
max_product(Root) ->
    Sums = collect_sums(Root),
    Total = lists:max(Sums),
    {Max, _} = lists:foldl(fun(S, {AccMax, Total}) ->
                               Product = S * (Total - S),
                               {max(AccMax, Product), Total}
                           end, {0, Total}, Sums),
    Max.

collect_sums(Root) ->
    {Sums, _} = collect_sums(Root, []),
    Sums.

collect_sums(null, Sums) -> {Sums, 0};
collect_sums(#tree_node{val = Val, left = Left, right = Right}, Sums) ->
    {Sums1, LeftSum} = collect_sums(Left, Sums),
    {Sums2, RightSum} = collect_sums(Right, Sums1),
    Total = Val + LeftSum + RightSum,
    {[Total | Sums2], Total}.