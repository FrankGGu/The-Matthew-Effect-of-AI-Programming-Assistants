-spec min_operations(Nums1 :: [integer()], Nums2 :: [integer()], K :: integer()) -> integer().
min_operations(Nums1, Nums2, K) ->
    case K of
        0 ->
            case lists:all(fun({X, Y}) -> X == Y end, lists:zip(Nums1, Nums2)) of
                true -> 0;
                false -> -1
            end;
        _ ->
            {SumDiff, SumOps} = lists:foldl(
                fun({X, Y}, {Diff, Ops}) ->
                    Delta = Y - X,
                    case Delta rem K of
                        0 ->
                            {Diff + Delta, Ops + abs(Delta div K)};
                        _ ->
                            {Diff, Ops}
                    end
                end,
                {0, 0},
                lists:zip(Nums1, Nums2)
            ),
            case SumDiff of
                0 -> SumOps div 2;
                _ -> -1
            end
    end.