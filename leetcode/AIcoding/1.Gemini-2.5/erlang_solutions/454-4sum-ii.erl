-module(solution).
-export([fourSumCount/4]).

fourSumCount(Nums1, Nums2, Nums3, Nums4) ->
    SumABCounts = lists:foldl(
        fun(A, AccMap) ->
            lists:foldl(
                fun(B, InnerAccMap) ->
                    SumAB = A + B,
                    maps:update_with(SumAB, fun(Count) -> Count + 1 end, 1, InnerAccMap)
                end,
                AccMap,
                Nums2
            )
        end,
        maps:new(),
        Nums1
    ),

    lists:foldl(
        fun(C, TotalCount) ->
            lists:foldl(
                fun(D, InnerTotalCount) ->
                    SumCD = C + D,
                    Target = -SumCD,
                    case maps:find(Target, SumABCounts) of
                        {ok, CountAB} ->
                            InnerTotalCount + CountAB
                        _ ->
                            InnerTotalCount
                    end
                end,
                TotalCount,
                Nums4
            )
        end,
        0,
        Nums3
    ).