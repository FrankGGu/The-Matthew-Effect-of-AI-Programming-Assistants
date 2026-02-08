-module(solution).
-export([waysToMakeFairArray/1]).

waysToMakeFairArray(Nums) ->
    N = length(Nums),

    {PrefixEvenList, PrefixOddList} = calculate_prefix_sums_list(Nums),

    PrefixEvenArr = array:from_list(PrefixEvenList),
    PrefixOddArr = array:from_list(PrefixOddList),

    TotalEvenSum = array:get(N-1, PrefixEvenArr),
    TotalOddSum = array:get(N-1, PrefixOddArr),

    check_indices_array(0, N, PrefixEvenArr, PrefixOddArr, TotalEvenSum, TotalOddSum, 0).

calculate_prefix_sums_list(Nums) ->
    calculate_prefix_sums_list_recursive(Nums, 0, 0, 0, [], []).

calculate_prefix_sums_list_recursive([], _Index, _CurrentEvenSum, _CurrentOddSum, AccEven, AccOdd) ->
    {lists:reverse(AccEven), lists:reverse(AccOdd)};
calculate_prefix_sums_list_recursive([H|T], Index, CurrentEvenSum, CurrentOddSum, AccEven, AccOdd) ->
    {FinalEvenSum, FinalOddSum} = 
        if 
            Index rem 2 == 0 ->
                {CurrentEvenSum + H, CurrentOddSum};
            true ->
                {CurrentEvenSum, CurrentOddSum + H}
        end,

    calculate_prefix_sums_list_recursive(T, Index + 1, FinalEvenSum, FinalOddSum, [FinalEvenSum | AccEven], [FinalOddSum | AccOdd]).

check_indices_array(I, N, PrefixEvenArr, PrefixOddArr, TotalEvenSum, TotalOddSum, AccCount) ->
    if 
        I == N -> 
            AccCount;
        true ->
            SumEvenLeft = if I == 0 -> 0; true -> array:get(I-1, PrefixEvenArr) end,
            SumOddLeft = if I == 0 -> 0; true -> array:get(I-1, PrefixOddArr) end,

            SumEvenRightOriginalIndices = TotalEvenSum - array:get(I, PrefixEvenArr),
            SumOddRightOriginalIndices = TotalOddSum - array:get(I, PrefixOddArr),

            NewSumEven = SumEvenLeft + SumOddRightOriginalIndices,
            NewSumOdd = SumOddLeft + SumEvenRightOriginalIndices,

            NewAccCount = if NewSumEven == NewSumOdd -> AccCount + 1; true -> AccCount end,

            check_indices_array(I+1, N, PrefixEvenArr, PrefixOddArr, TotalEvenSum, TotalOddSum, NewAccCount)
    end.