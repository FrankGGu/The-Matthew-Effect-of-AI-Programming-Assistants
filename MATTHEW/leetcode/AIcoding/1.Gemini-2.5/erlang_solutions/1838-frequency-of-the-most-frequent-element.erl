-module(solution).
-export([frequency/2]).

frequency(Nums, K) ->
    SortedNums = lists:sort(Nums),
    % Acc: {Queue, CurrentSum, MaxFreq, LeftIdx, RightIdx}
    % Queue: {FrontList, BackList} for O(1) amortized enqueue/dequeue
    % CurrentSum: sum of elements in the current window
    % MaxFreq: maximum frequency found so far
    % LeftIdx: 0-based index of the left pointer of the window
    % RightIdx: 0-based index of the right pointer of the window (implicit in foldl, updated in acc)
    InitialAcc = {{[], []}, 0, 0, 0, 0},
    {_Q, _CurrentSum, MaxF, _LeftIdx, _RightIdx} = lists:foldl(
        fun(RightNum, {Q, CurrentSum, MaxF_acc, LeftIdx, RightIdx}) ->
            % 1. Add the current element (RightNum) to the window
            {Q_new_elem, CurrentSum_new_elem} = enqueue(Q, CurrentSum, RightNum),

            % 2. Adjust the window by shrinking from the left if the cost exceeds K
            %    Target value for the window is RightNum (the largest element)
            {AdjustedQ, AdjustedCurrentSum, AdjustedLeftIdx} =
                adjust_window_queue(Q_new_elem, CurrentSum_new_elem, K, LeftIdx, RightIdx, RightNum),

            % 3. Calculate the new maximum frequency
            WindowSize = RightIdx - AdjustedLeftIdx + 1,
            NewMaxF = max(MaxF_acc, WindowSize),

            % 4. Prepare accumulator for the next iteration (move RightIdx forward)
            {AdjustedQ, AdjustedCurrentSum, NewMaxF, AdjustedLeftIdx, RightIdx + 1}
        end,
        InitialAcc,
        SortedNums
    ),
    MaxF.

enqueue({Front, Back}, CurrentSum, Elem) ->
    {{Front, [Elem | Back]}, CurrentSum + Elem}.

dequeue({[], Back}, CurrentSum) ->
    NewFront = lists:reverse(Back),
    [H | T] = NewFront,
    {H, {T, []}, CurrentSum - H};
dequeue({[H | T], Back}, CurrentSum) ->
    {H, {T, Back}, CurrentSum - H}.

adjust_window_queue(Q, CurrentSum, K, LeftIdx, RightIdx, TargetNum) ->
    WindowSize = RightIdx - LeftIdx + 1,
    Cost = (TargetNum * WindowSize) - CurrentSum,

    if Cost =< K ->
        % Window is valid, no more shrinking needed
        {Q, CurrentSum, LeftIdx};
    true ->
        % Window is invalid, shrink from the left
        {_LeftNum, NewQ, NewCurrentSum} = dequeue(Q, CurrentSum),
        NewLeftIdx = LeftIdx + 1,
        % Recurse with the shrunk window
        adjust_window_queue(NewQ, NewCurrentSum, K, NewLeftIdx, RightIdx, TargetNum)
    end.