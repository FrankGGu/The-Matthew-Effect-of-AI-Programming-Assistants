-module(solution).
-export([maximum_beautiful_towers/1]).

maximum_beautiful_towers(HeightsList) ->
    N = length(HeightsList),
    Heights = array:from_list(HeightsList),

    LeftSum = calculate_left_sum(N, Heights),
    RightSum = calculate_right_sum(N, Heights),

    calculate_max_total_sum(N, Heights, LeftSum, RightSum).

calculate_left_sum(N, Heights) ->
    LeftSum = array:new([{size, N}, {fixed, true}]),
    Stack = [], % Stack stores {Index, Height} pairs, top of stack is head of list

    lists:foldl(
        fun(I, {CurrentLeftSum, CurrentStack}) ->
            HeightI = array:get(I, Heights),

            {NewStackPopped, PrevSmallerIdx} = pop_stack_helper(CurrentStack, HeightI, -1),

            PrevLeftSum = case PrevSmallerIdx of
                              -1 -> 0;
                              _ -> array:get(PrevSmallerIdx, CurrentLeftSum)
                          end,

            CurrentSum = PrevLeftSum + HeightI * (I - PrevSmallerIdx),

            UpdatedLeftSum = array:set(I, CurrentSum, CurrentLeftSum),
            UpdatedStack = [{I, HeightI} | NewStackPopped], % Push {Index, Height}
            {UpdatedLeftSum, UpdatedStack}
        end,
        {LeftSum, Stack},
        lists:seq(0, N - 1)
    ) |> element(1). % Extract the final LeftSum array

calculate_right_sum(N, Heights) ->
    RightSum = array:new([{size, N}, {fixed, true}]),
    Stack = [], % Stack stores {Index, Height} pairs

    lists:foldr( % Iterate from N-1 down to 0
        fun(I, {CurrentRightSum, CurrentStack}) ->
            HeightI = array:get(I, Heights),

            {NewStackPopped, NextSmallerIdx} = pop_stack_helper(CurrentStack, HeightI, N),

            NextRightSum = case NextSmallerIdx of
                               N -> 0;
                               _ -> array:get(NextSmallerIdx, CurrentRightSum)
                           end,

            CurrentSum = NextRightSum + HeightI * (NextSmallerIdx - I),

            UpdatedRightSum = array:set(I, CurrentSum, CurrentRightSum),
            UpdatedStack = [{I, HeightI} | NewStackPopped], % Push {Index, Height}
            {UpdatedRightSum, UpdatedStack}
        end,
        {RightSum, Stack},
        lists:seq(0, N - 1)
    ) |> element(1). % Extract the final RightSum array

pop_stack_helper(Stack, HeightI, DefaultBoundaryIdx) ->
    pop_stack_helper_loop(Stack, HeightI, DefaultBoundaryIdx).

pop_stack_helper_loop([{_Idx, H} | Rest], HeightI, DefaultBoundaryIdx) when H >= HeightI ->
    pop_stack_helper_loop(Rest, HeightI, DefaultBoundaryIdx);
pop_stack_helper_loop(Stack, _HeightI, DefaultBoundaryIdx) ->
    case Stack of
        [{Idx, _} | _] -> {Stack, Idx};
        [] -> {Stack, DefaultBoundaryIdx}
    end.

calculate_max_total_sum(N, Heights, LeftSum, RightSum) ->
    lists:foldl(
        fun(I, MaxSoFar) ->
            HeightI = array:get(I, Heights),
            CurrentTotalSum = array:get(I, LeftSum) + array:get(I, RightSum) - HeightI,
            max(MaxSoFar, CurrentTotalSum)
        end,
        0, % Initial max sum
        lists:seq(0, N - 1)
    ).