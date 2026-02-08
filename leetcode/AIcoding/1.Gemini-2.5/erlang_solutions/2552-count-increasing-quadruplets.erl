-module(solution).
-export([countQuadruplets/1]).

-record(bit, {size :: integer(), tree :: array:array()}).

new_bit(Size) ->
    #bit{size = Size, tree = array:new([{size, Size + 1}, {default, 0}])}.

bit_update(Bit = #bit{size = Size, tree = Tree}, Index, Val) ->
    CurrentTree = Tree,
    UpdatedTree = update_loop(CurrentTree, Index, Size, Val),
    Bit#bit{tree = UpdatedTree}.

update_loop(Tree, Idx, Size, Val) ->
    if Idx =< Size ->
        NewTree = array:set(Idx, array:get(Idx, Tree) + Val, Tree),
        update_loop(NewTree, Idx + (Idx band -Idx), Size, Val);
    true ->
        Tree
    end.

bit_query_prefix_sum(Bit = #bit{tree = Tree}, Index) ->
    query_loop(Tree, Index, 0).

query_loop(Tree, Idx, Sum) ->
    if Idx > 0 ->
        query_loop(Tree, Idx - (Idx band -Idx), Sum + array:get(Idx, Tree));
    true ->
        Sum
    end.

bit_query_suffix_sum(Bit = #bit{size = Size}, Index) ->
    bit_query_prefix_sum(Bit, Size) - bit_query_prefix_sum(Bit, Index - 1).

countQuadruplets(Nums) ->
    N = length(Nums),
    if N < 4 -> 0;
       true ->
            UniqueSortedNums = lists:usort(Nums),
            RankMap = dict:from_list(lists:zip(UniqueSortedNums, lists:seq(0, length(UniqueSortedNums) - 1))),
            Ranks = [dict:fetch(X, RankMap) || X <- Nums],
            MaxRank = length(UniqueSortedNums),

            RanksArray = array:from_list(Ranks),

            TotalQuadruplets = 0,

            BitLeft0 = new_bit(MaxRank),
            Rank0 = array:get(0, RanksArray),
            InitialBitLeft = bit_update(BitLeft0, Rank0 + 1, 1),

            {FinalTotal, _} = lists:foldl(fun(J, {AccTotal, CurrentBitLeft}) ->
                BitRightInitial = new_bit(MaxRank),
                BitRight = lists:foldl(fun(L_idx, BR_acc) ->
                    bit_update(BR_acc, array:get(L_idx, RanksArray) + 1, 1)
                end, BitRightInitial, lists:seq(J + 1, N - 1)),

                {NewAccTotal, _} = lists:foldl(fun(K, {InnerAccTotal, CurrentBitRight}) ->
                    RankK = array:get(K, RanksArray),
                    RankJ = array:get(J, RanksArray),

                    LeftCount = bit_query_prefix_sum(CurrentBitLeft, RankK),
                    RightCount = bit_query_suffix_sum(CurrentBitRight, RankJ + 2),

                    NewInnerAccTotal = InnerAccTotal + (LeftCount * RightCount),

                    UpdatedBitRight = bit_update(CurrentBitRight, RankK + 1, -1),

                    {NewInnerAccTotal, UpdatedBitRight}
                end, {AccTotal, BitRight}, lists:seq(J + 1, N - 2)),

                UpdatedBitLeft = bit_update(CurrentBitLeft, array:get(J, RanksArray) + 1, 1),

                {NewAccTotal, UpdatedBitLeft}
            end, {TotalQuadruplets, InitialBitLeft}, lists:seq(1, N - 3)),
            FinalTotal
    end.