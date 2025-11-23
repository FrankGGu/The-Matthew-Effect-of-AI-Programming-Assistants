-module(solution).
-export([countPairs/3]).

-include_lib("array/include/array.hrl").

countPairs(N, Edges, Queries) ->
    Degs = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),
    AdjMap = maps:new(),

    {FinalDegs, FinalAdjMap} = lists:foldl(
        fun([U, V], {CurrentDegs, CurrentAdjMap}) ->
            NewDegs1 = array:set(U, array:get(U, CurrentDegs) + 1, CurrentDegs),
            NewDegs2 = array:set(V, array:get(V, NewDegs1) + 1, NewDegs1),
            {U1, V1} = if U < V -> {U, V}; true -> {V, U} end,
            NewAdjMap = maps:update_with({U1, V1}, fun(C) -> C + 1 end, 1, CurrentAdjMap),
            {NewDegs2, NewAdjMap}
        end,
        {Degs, AdjMap},
        Edges
    ),

    NodeDegreesList = [array:get(I, FinalDegs) || I <- lists:seq(1, N)],
    SortedDegreesArray = array:from_list(lists:sort(NodeDegreesList)),

    MaxPossibleSumDeg = 2 * (N - 1),
    AnsArr = array:new([{size, MaxPossibleSumDeg + 1}, {fixed, true}, {default, 0}]),

    AnsArrFinal = calculate_ans_arr(N, SortedDegreesArray, MaxPossibleSumDeg, AnsArr),

    EdgeSumDegrees = array:new([{size, MaxPossibleSumDeg + 1}, {fixed, true}, {default, 0}]),

    EdgeSumDegreesFinal = maps:foldl(
        fun({U, V}, Count, CurrentEdgeSumDegrees) ->
            SumDeg = array:get(U, FinalDegs) + array:get(V, FinalDegs),
            array:set(SumDeg, array:get(SumDeg, CurrentEdgeSumDegrees) + Count, CurrentEdgeSumDegrees)
        end,
        EdgeSumDegrees,
        FinalAdjMap
    ),

    lists:map(
        fun(Qval) ->
            Res = if Qval >= 0 andalso Qval =< MaxPossibleSumDeg ->
                      array:get(Qval, AnsArrFinal);
                    Qval < 0 ->
                      array:get(0, AnsArrFinal);
                    true ->
                      0
                  end,

            Adjustment = if Qval + 1 >= 0 andalso Qval + 1 =< MaxPossibleSumDeg ->
                             array:get(Qval + 1, EdgeSumDegreesFinal);
                           true -> 0
                         end,
            Res - Adjustment
        end,
        Queries
    ).

calculate_ans_arr(N, SortedDegreesArray, MaxSumDeg, AnsArr) ->
    calculate_ans_arr_loop(N, SortedDegreesArray, MaxSumDeg, AnsArr, 0, N - 1, 0).

calculate_ans_arr_loop(N, SortedDegreesArray, K, AnsArr, Left, Right, CurrentCount) ->
    if K < 0 ->
        AnsArr;
    true ->
        {NewRight, NewCurrentCount} = 
            adjust_right_pointer(SortedDegreesArray, K, Left, Right, CurrentCount),

        NewAnsArr = array:set(K, NewCurrentCount, AnsArr),

        NewLeft = if Left < NewRight andalso array:get(Left, SortedDegreesArray) + array:get(NewRight, SortedDegreesArray) <= K ->
                      Left + 1;
                  true ->
                      Left
                  end,

        calculate_ans_arr_loop(N, SortedDegreesArray, K - 1, NewAnsArr, NewLeft, NewRight, NewCurrentCount)
    end.

adjust_right_pointer(SortedDegreesArray, K, Left, Right, CurrentCount) ->
    if Left < Right andalso array:get(Left, SortedDegreesArray) + array:get(Right, SortedDegreesArray) > K ->
        adjust_right_pointer(SortedDegreesArray, K, Left, Right - 1, CurrentCount + (Right - Left));
    true ->
        {Right, CurrentCount}
    end.