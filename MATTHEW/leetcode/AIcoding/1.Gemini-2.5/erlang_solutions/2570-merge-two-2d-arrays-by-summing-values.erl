-module(solution).
-export([merge_arrays/2]).

merge_arrays(Nums1, Nums2) ->
    MergedMap = #{},
    MapAfterNums1 = lists:foldl(
        fun([Id, Val], AccMap) ->
            maps:update_with(Id, fun(OldVal) -> OldVal + Val end, Val, AccMap)
        end,
        MergedMap,
        Nums1
    ),
    FinalMap = lists:foldl(
        fun([Id, Val], AccMap) ->
            maps:update_with(Id, fun(OldVal) -> OldVal + Val end, Val, AccMap)
        end,
        MapAfterNums1,
        Nums2
    ),
    lists:sort(fun([IdA, _], [IdB, _]) -> IdA < IdB end, maps:to_list(FinalMap)).