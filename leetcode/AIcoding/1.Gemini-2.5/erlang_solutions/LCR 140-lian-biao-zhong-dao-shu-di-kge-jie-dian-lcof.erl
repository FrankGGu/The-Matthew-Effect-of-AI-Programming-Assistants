-module(solution).
-export([beautiful_towers_ii/1]).

beautiful_towers_ii(MaxHeightsList) ->
    N = length(MaxHeightsList),
    MaxHeights = array:from_list(MaxHeightsList),

    {_FinalStackL, _FinalCurrentSumL, LeftSums} = lists:foldl(
        fun(I, {Stack, CurrentSum, AccLeftSums}) ->
            H_i = array:get(I, MaxHeights),

            {PoppedStack, PoppedSum} = pop_left(Stack, CurrentSum, H_i),

            PrevIdx = case PoppedStack of
                          [] -> -1;
                          [{PIdx, _}|_] -> PIdx
                      end,
            CurrentSumForI = PoppedSum + (I - PrevIdx) * H_i,

            UpdatedStack = [{I, H_i}|PoppedStack],

            UpdatedAccLeftSums = array:set(I, CurrentSumForI, AccLeftSums),
            {UpdatedStack, CurrentSumForI, UpdatedAccLeftSums}
        end,
        {[], 0, array:new(N)},
        lists:seq(0, N-1)
    ),

    {_FinalStackR, _FinalCurrentSumR, RightSums} = lists:foldl(
        fun(I, {Stack, CurrentSum, AccRightSums}) ->
            H_i = array:get(I, MaxHeights),

            {PoppedStack, PoppedSum} = pop_right(Stack, CurrentSum, H_i, N),

            PrevIdx = case PoppedStack of
                          [] -> N;
                          [{PIdx, _}|_] -> PIdx
                      end,
            CurrentSumForI = PoppedSum + (PrevIdx - I) * H_i,

            UpdatedStack = [{I, H_i}|PoppedStack],

            UpdatedAccRightSums = array:set(I, CurrentSumForI, AccRightSums),
            {UpdatedStack, CurrentSumForI, UpdatedAccRightSums}
        end,
        {[], 0, array:new(N)},
        lists:seq(N-1, 0, -1)
    ),

    lists:foldl(
        fun(I, MaxSum) ->
            H_i = array:get(I, MaxHeights),
            Left = array:get(I, LeftSums),
            Right = array:get(I, RightSums),
            CurrentTotalSum = Left + Right - H_i,
            max(MaxSum, CurrentTotalSum)
        end,
        0,
        lists:seq(0, N-1)
    ).

pop_left(Stack, CurrentSum, H_i) ->
    case Stack of
        [{TopIdx, TopVal}|RestStack] when TopVal >= H_i ->
            PrevIdx = case RestStack of
                          [] -> -1;
                          [{PIdx, _}|_] -> PIdx
                      end,
            NewCurrentSum = CurrentSum - (TopIdx - PrevIdx) * TopVal,
            pop_left(RestStack, NewCurrentSum, H_i);
        _ ->
            {Stack, CurrentSum}
    end.

pop_right(Stack, CurrentSum, H_i, N) ->
    case Stack of
        [{TopIdx, TopVal}|RestStack] when TopVal >= H_i ->
            PrevIdx = case RestStack of
                          [] -> N;
                          [{PIdx, _}|_] -> PIdx
                      end,
            NewCurrentSum = CurrentSum - (PrevIdx - TopIdx) * TopVal,
            pop_right(RestStack, NewCurrentSum, H_i, N);
        _ ->
            {Stack, CurrentSum}
    end.