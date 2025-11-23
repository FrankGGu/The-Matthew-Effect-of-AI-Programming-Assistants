-module(solution).
-export([regionsBySlashes/1]).

find(ParentArray, NodeId) ->
    ParentId = array:get(NodeId, ParentArray),
    if
        ParentId == NodeId -> {ParentArray, NodeId};
        true ->
            {NewParentArray1, RootId} = find(ParentArray, ParentId),
            {array:set(NodeId, RootId, NewParentArray1), RootId}
    end.

union(ParentArray, RankArray, NumRegions, Node1, Node2) ->
    {ParentArray1, Root1} = find(ParentArray, Node1),
    {ParentArray2, Root2} = find(ParentArray1, Node2),
    if
        Root1 == Root2 -> {ParentArray2, RankArray, NumRegions};
        true ->
            Rank1 = array:get(Root1, RankArray),
            Rank2 = array:get(Root2, RankArray),
            if
                Rank1 < Rank2 ->
                    {array:set(Root1, Root2, ParentArray2), RankArray, NumRegions - 1};
                Rank1 > Rank2 ->
                    {array:set(Root2, Root1, ParentArray2), RankArray, NumRegions - 1};
                true ->
                    {array:set(Root2, Root1, ParentArray2), array:set(Root1, Rank1 + 1, RankArray), NumRegions - 1}
            end
    end.

regionsBySlashes(Grid) ->
    N = length(Grid),
    TotalNodes = N * N * 4,

    InitialParentArray = array:from_list(lists:seq(0, TotalNodes - 1)),
    InitialRankArray = array:new([{size, TotalNodes}, {default, 0}]),
    InitialNumRegions = TotalNodes,

    {_FinalParentArray, _FinalRankArray, FinalNumRegions} = lists:foldl(
        fun(R, {AccParentArray, AccRankArray, AccNumRegions}) ->
            lists:foldl(
                fun(C, {AccParentArrayInner, AccRankArrayInner, AccNumRegionsInner}) ->
                    CellRow = lists:nth(R + 1, Grid),
                    CellChar = element(C + 1, CellRow),

                    NodeIdx = fun(Row, Col, Part) -> Row * N * 4 + Col * 4 + Part end,

                    {NewParentArray1, NewRankArray1, NewNumRegions1} =
                        case CellChar of
                            $  ->
                                {PA0, RA0, NR0} = union(AccParentArrayInner, AccRankArrayInner, AccNumRegionsInner, NodeIdx(R, C, 0), NodeIdx(R, C, 1)),
                                {PA1, RA1, NR1} = union(PA0, RA0, NR0, NodeIdx(R, C, 1), NodeIdx(R, C, 2)),
                                union(PA1, RA1, NR1, NodeIdx(R, C, 2), NodeIdx(R, C, 3));
                            $/ ->
                                {PA0, RA0, NR0} = union(AccParentArrayInner, AccRankArrayInner, AccNumRegionsInner, NodeIdx(R, C, 0), NodeIdx(R, C, 3)),
                                union(PA0, RA0, NR0, NodeIdx(R, C, 1), NodeIdx(R, C, 2));
                            $\ ->
                                {PA0, RA0, NR0} = union(AccParentArrayInner, AccRankArrayInner, AccNumRegionsInner, NodeIdx(R, C, 0), NodeIdx(R, C, 1)),
                                union(PA0, RA0, NR0, NodeIdx(R, C, 3), NodeIdx(R, C, 2))
                        end,

                    {NewParentArray2, NewRankArray2, NewNumRegions2} =
                        if
                            R > 0 ->
                                union(NewParentArray1, NewRankArray1, NewNumRegions1, NodeIdx(R, C, 0), NodeIdx(R - 1, C, 2));
                            true -> {NewParentArray1, NewRankArray1, NewNumRegions1}
                        end,

                    {NewParentArray3, NewRankArray3, NewNumRegions3} =
                        if
                            C > 0 ->
                                union(NewParentArray2, NewRankArray2, NewNumRegions2, NodeIdx(R, C, 3), NodeIdx(R, C - 1, 1));
                            true -> {NewParentArray2, NewRankArray2, NewNumRegions2}
                        end,

                    {NewParentArray3, NewRankArray3, NewNumRegions3}

                end, {NewParentArray1, NewRankArray1, NewNumRegions1}, lists:seq(0, N - 1))
        end, {InitialParentArray, InitialRankArray, InitialNumRegions}, lists:seq(0, N - 1)),

    FinalNumRegions.