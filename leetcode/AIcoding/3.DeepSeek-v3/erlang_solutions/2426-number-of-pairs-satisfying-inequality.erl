-spec num_pairs_satisfying_inequality(Nums1 :: [integer()], Nums2 :: [integer()], Diff :: integer()) -> integer().
num_pairs_satisfying_inequality(Nums1, Nums2, Diff) ->
    N = length(Nums1),
    Diffs = lists:zipwith(fun(X, Y) -> X - Y end, Nums1, Nums2),
    Tree = gb_trees:empty(),
    {Tree1, _} = lists:foldl(fun(D, {T, _}) -> 
        Count = count_leq(T, D + Diff),
        {gb_trees:enter(D, true, T), Count}
    end, {Tree, 0}, Diffs),
    lists:foldl(fun(D, {T, Acc}) -> 
        Count = count_leq(T, D + Diff),
        {gb_trees:enter(D, true, T), Acc + Count}
    end, {Tree1, 0}, Diffs) element 2.

count_leq(Tree, Key) ->
    case gb_trees:is_empty(Tree) of
        true -> 0;
        false ->
            case gb_trees:lookup(Key, Tree) of
                {value, _} -> 
                    {_, Left} = gb_trees:take_smallest(Tree),
                    count_leq(Left, Key) + 1;
                none ->
                    case gb_trees:is_empty(Tree) of
                        true -> 0;
                        false ->
                            {K, _, Right} = gb_trees:take_largest(Tree),
                            if 
                                K =< Key -> gb_trees:size(Tree);
                                true -> count_leq(gb_trees:delete(K, Tree), Key)
                            end
                    end
            end
    end.