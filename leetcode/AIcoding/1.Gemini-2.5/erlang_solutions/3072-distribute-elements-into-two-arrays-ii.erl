-module(solution).
-export([distributeElements/1]).

bit_new(Size) ->
    array:new([{size, Size + 1}, {fixed, true}, {default, 0}]).

bit_update(Tree, Idx, Delta) ->
    Size = array:size(Tree) - 1,
    bit_update_loop(Tree, Idx, Delta, Size).

bit_update_loop(Tree, Idx, Delta, Size) when Idx =< Size ->
    NewTree = array:set(Idx, array:get(Idx, Tree) + Delta, Tree),
    bit_update_loop(NewTree, Idx + (Idx band -Idx), Delta, Size);
bit_update_loop(Tree, _, _, _) ->
    Tree.

bit_query_prefix(Tree, Idx) ->
    bit_query_prefix_loop(Tree, Idx, 0).

bit_query_prefix_loop(Tree, Idx, Sum) when Idx > 0 ->
    NewSum = Sum + array:get(Idx, Tree),
    bit_query_prefix_loop(Tree, Idx - (Idx band -Idx), NewSum);
bit_query_prefix_loop(_, _, Sum) ->
    Sum.

distributeElements(Nums) ->
    N = length(Nums),
    if N < 2 ->
        Nums;
    true ->
        UniqueSortedNums = lists:usort(Nums),
        ValueToIndexMap = maps:from_list(lists:zip(UniqueSortedNums, lists:seq(1, length(UniqueSortedNums)))),
        MaxCompressedIndex = length(UniqueSortedNums),

        Bit1 = bit_new(MaxCompressedIndex),
        Bit2 = bit_new(MaxCompressedIndex),

        [Num0 | RestNums] = Nums,
        [Num1 | RemainingNums] = RestNums,

        Arr1Rev = [Num0],
        Arr2Rev = [Num1],
        Len1 = 1,
        Len2 = 1,

        Idx0 = maps:get(Num0, ValueToIndexMap),
        NewBit1 = bit_update(Bit1, Idx0, 1),

        Idx1 = maps:get(Num1, ValueToIndexMap),
        NewBit2 = bit_update(Bit2, Idx1, 1),

        {FinalArr1Rev, FinalArr2Rev, _, _, _, _} =
            lists:foldl(
                fun(Num, {A1R, A2R, B1, B2, L1, L2}) ->
                    CompressedIdx = maps:get(Num, ValueToIndexMap),

                    Count1 = bit_query_prefix(B1, MaxCompressedIndex) - bit_query_prefix(B1, CompressedIdx),
                    Count2 = bit_query_prefix(B2, MaxCompressedIndex) - bit_query_prefix(B2, CompressedIdx),

                    if Count1 > Count2 ->
                        {[Num | A1R], A2R, bit_update(B1, CompressedIdx, 1), B2, L1 + 1, L2};
                    Count2 > Count1 ->
                        {A1R, [Num | A2R], B1, bit_update(B2, CompressedIdx, 1), L1, L2 + 1};
                    true ->
                        if L1 =< L2 ->
                            {[Num | A1R], A2R, bit_update(B1, CompressedIdx, 1), B2, L1 + 1, L2};
                        true ->
                            {A1R, [Num | A2R], B1, bit_update(B2, CompressedIdx, 1), L1, L2 + 1}
                        end
                    end
                end,
                {Arr1Rev, Arr2Rev, NewBit1, NewBit2, Len1, Len2},
                RemainingNums
            ),

        lists:reverse(FinalArr1Rev) ++ lists:reverse(FinalArr2Rev)
    end.