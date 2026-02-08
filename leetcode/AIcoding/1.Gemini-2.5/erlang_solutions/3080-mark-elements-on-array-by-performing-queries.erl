-module(solution).
-export([markElements/2]).

markElements(Nums, Queries) ->
    N = length(Nums),

    InitialTotalSum = lists:sum(Nums),

    IndexedNums = lists:zip(Nums, lists:seq(0, N - 1)),

    SortedValueIndexPairs = array:from_list(
        lists:sort(
            fun({V1, I1}, {V2, I2}) ->
                if
                    V1 < V2 -> true;
                    V1 > V2 -> false;
                    true -> I1 < I2
                end
            end,
            IndexedNums
        )
    ),

    InitialMarkedStatus = array:new(N, {default, false}),

    process_queries(
        Queries,
        Nums,
        InitialMarkedStatus,
        SortedValueIndexPairs,
        0,
        InitialTotalSum,
        []
    ).

process_queries([], _Nums, _MarkedStatus, _SortedPairs, _SortedPairsPtr, _TotalSum, Acc) ->
    lists:reverse(Acc);
process_queries(
    [[QueryIndex, K] | RestQueries],
    Nums,
    MarkedStatus,
    SortedValueIndexPairs,
    SortedPairsPtr,
    TotalSum,
    Acc
) ->
    ValToMark = lists:nth(QueryIndex + 1, Nums),

    IsAlreadyMarked = array:get(QueryIndex, MarkedStatus),

    {UpdatedMarkedStatus1, UpdatedTotalSum1} =
        if
            not IsAlreadyMarked ->
                {array:set(QueryIndex, true, MarkedStatus), TotalSum - ValToMark};
            true ->
                {MarkedStatus, TotalSum}
        end,

    {UpdatedMarkedStatus2, UpdatedTotalSum2, UpdatedSortedPairsPtr} =
        mark_k_smallest(
            K,
            UpdatedMarkedStatus1,
            SortedValueIndexPairs,
            SortedPairsPtr,
            UpdatedTotalSum1
        ),

    NewAcc = [UpdatedTotalSum2 | Acc],

    process_queries(
        RestQueries,
        Nums,
        UpdatedMarkedStatus2,
        SortedValueIndexPairs,
        UpdatedSortedPairsPtr,
        UpdatedTotalSum2,
        NewAcc
    ).

mark_k_smallest(
    0, MarkedStatus, _SortedValueIndexPairs, SortedPairsPtr, TotalSum
) ->
    {MarkedStatus, TotalSum, SortedPairsPtr};
mark_k_smallest(
    RemainingK, MarkedStatus, SortedValueIndexPairs, SortedPairsPtr, TotalSum
) when SortedPairsPtr < array:size(SortedValueIndexPairs) ->
    {Val, Idx} = array:get(SortedPairsPtr, SortedValueIndexPairs),

    IsMarked = array:get(Idx, MarkedStatus),

    if
        not IsMarked ->
            NewMarkedStatus = array:set(Idx, true, MarkedStatus),
            NewTotalSum = TotalSum - Val,
            mark_k_smallest(
                RemainingK - 1,
                NewMarkedStatus,
                SortedValueIndexPairs,
                SortedPairsPtr + 1,
                NewTotalSum
            );
        true ->
            mark_k_smallest(
                RemainingK,
                MarkedStatus,
                SortedValueIndexPairs,
                SortedPairsPtr + 1,
                TotalSum
            )
    end;
mark_k_smallest(
    _RemainingK, MarkedStatus, _SortedValueIndexPairs, SortedPairsPtr, TotalSum
) ->
    {MarkedStatus, TotalSum, SortedPairsPtr}.