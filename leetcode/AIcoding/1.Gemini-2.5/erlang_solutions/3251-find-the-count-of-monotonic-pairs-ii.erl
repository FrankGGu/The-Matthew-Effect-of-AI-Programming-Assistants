-module(solution).
-export([monotonic_pairs/1]).

-include_lib("kernel/include/array.hrl").

monotonic_pairs(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            UniqueSortedNums = lists:usort(Nums),
            {Map, MaxCompressedVal} = lists:foldl(
                fun(Val, {AccMap, Idx}) -> {maps:put(Val, Idx, AccMap), Idx + 1} end,
                {maps:new(), 1},
                UniqueSortedNums
            ),
            CompressedNums = lists:map(fun(Val) -> maps:get(Val, Map) end, Nums),

            FenwickTree = fenwick_new(MaxCompressedVal),

            {_FinalFenwickTree, FinalCount} = lists:foldl(
                fun(Val, {AccFenwickTree, AccCount}) ->
                    CurrentCount = fenwick_query(AccFenwickTree, MaxCompressedVal) - fenwick_query(AccFenwickTree, Val - 1),

                    NewAccCount = AccCount + CurrentCount,
                    NewFenwickTree = fenwick_update(AccFenwickTree, Val, 1, MaxCompressedVal),

                    {NewFenwickTree, NewAccCount}
                end,
                {FenwickTree, 0},
                lists:reverse(CompressedNums)
            ),
            FinalCount
    end.

fenwick_new(Size) ->
    array:new([{size, Size + 1}, {fixed, true}, {default, 0}]).

fenwick_update(FenwickTree, Idx, Val, MaxIdx) ->
    fenwick_update_loop(FenwickTree, Idx, Val, MaxIdx).

fenwick_update_loop(FenwickTree, Idx, Val, MaxIdx) when Idx =< MaxIdx ->
    NewFenwickTree = array:set(Idx, array:get(Idx, FenwickTree) + Val, FenwickTree),
    fenwick_update_loop(NewFenwickTree, Idx + (Idx band -Idx), Val, MaxIdx);
fenwick_update_loop(FenwickTree, _, _, _) ->
    FenwickTree.

fenwick_query(FenwickTree, Idx) ->
    fenwick_query_loop(FenwickTree, Idx, 0).

fenwick_query_loop(FenwickTree, Idx, Acc) when Idx > 0 ->
    fenwick_query_loop(FenwickTree, Idx - (Idx band -Idx), Acc + array:get(Idx, FenwickTree));
fenwick_query_loop(_, 0, Acc) ->
    Acc.