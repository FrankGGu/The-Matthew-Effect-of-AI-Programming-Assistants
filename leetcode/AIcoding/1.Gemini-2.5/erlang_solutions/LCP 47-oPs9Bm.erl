-module(solution).
-export([maximum_sum_of_heights/1]).

maximum_sum_of_heights(Heights) ->
    N = length(Heights),

    IndexedHeights = lists:zip(lists:seq(0, N - 1), Heights),

    LeftPrefixSums = calculate_left_prefix_sums(IndexedHeights),
    RightPrefixSums = calculate_right_prefix_sums(IndexedHeights, N),

    Combined = lists:zip3(LeftPrefixSums, RightPrefixSums, Heights),

    lists:foldl(fun({LSum, RSum, H}, MaxSum) ->
        CurrentSum = LSum + RSum - H,
        max(MaxSum, CurrentSum)
    end, 0, Combined).

pop_stack_helper(Stack, CurrentHeight) ->
    case Stack of
        [] -> {[], 0};
        [{_PrevIdx, PrevEffectiveH, _PrevSum} | RestStack] when PrevEffectiveH > CurrentHeight ->
            pop_stack_helper(RestStack, CurrentHeight);
        [{_Idx, _H, Sum} | _] -> {Stack, Sum};
        [] -> {[], 0}
    end.

calculate_left_prefix_sums(IndexedHeights) ->
    {_, LeftSumsReversed} = lists:foldl(fun({I, CurrentHeight}, {Stack, AccSums}) ->
        {NewStack, SumBeforePopped} = pop_stack_helper(Stack, CurrentHeight),

        EffectivePrevIdx = case NewStack of
            [] -> -1;
            [{PrevIdx, _, _} | _] -> PrevIdx
        end,

        CurrentSum = SumBeforePopped + CurrentHeight * (I - EffectivePrevIdx),

        NewStackWithCurrent = [{I, CurrentHeight, CurrentSum} | NewStack],
        {NewStackWithCurrent, [CurrentSum | AccSums]}
    end, {[], []}, IndexedHeights),

    lists:reverse(LeftSumsReversed).

calculate_right_prefix_sums(IndexedHeights, N) ->
    ReversedIndexedHeights = lists:reverse(IndexedHeights),

    {_, RightSumsReversed} = lists:foldl(fun({I, CurrentHeight}, {Stack, AccSums}) ->
        {NewStack, SumBeforePopped} = pop_stack_helper(Stack, CurrentHeight),

        EffectivePrevIdx = case NewStack of
            [] -> N;
            [{PrevIdx, _, _} | _] -> PrevIdx
        end,

        CurrentSum = SumBeforePopped + CurrentHeight * (EffectivePrevIdx - I),

        NewStackWithCurrent = [{I, CurrentHeight, CurrentSum} | NewStack],
        {NewStackWithCurrent, [CurrentSum | AccSums]}
    end, {[], []}, ReversedIndexedHeights),

    lists:reverse(RightSumsReversed).