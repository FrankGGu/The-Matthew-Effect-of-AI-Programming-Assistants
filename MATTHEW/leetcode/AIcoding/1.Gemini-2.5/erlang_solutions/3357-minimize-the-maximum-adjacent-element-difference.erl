-module(solution).
-export([minimizeMaxAdjacentDifference/2]).

minimizeMaxAdjacentDifference(Nums, K) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),

    % If N-K is 0 or 1, there are no adjacent elements or only one element.
    % The maximum difference is 0 in such cases.
    if N - K =< 1 ->
        0;
    else
        Low = 0,
        High = lists:last(SortedNums) - hd(SortedNums),
        BinarySearch(Low, High, SortedNums, N, K, High)
    end.

BinarySearch(Low, High, SortedNums, N, K, Ans) ->
    if Low > High ->
        Ans;
    else
        Mid = Low + (High - Low) div 2,
        NumToKeep = N - K,
        MaxKept = max_kept_elements(Mid, SortedNums),
        if MaxKept >= NumToKeep ->
            BinarySearch(Low, Mid - 1, SortedNums, N, K, Mid);
        else
            BinarySearch(Mid + 1, High, SortedNums, N, K, Ans)
        end
    end.

max_kept_elements(X, SortedNums) ->
    N = length(SortedNums),
    if N == 0 -> 0;
       N == 1 -> 1;
    else
        % Deque stores {DPValue, ElementValue}
        % DPValue: max length of subsequence ending with ElementValue
        % ElementValue: nums[j]
        FirstNum = hd(SortedNums),
        InitialDeque = queue:in({1, FirstNum}, queue:new()),
        InitialMaxLen = 1,

        max_kept_elements_loop(X, tl(SortedNums), InitialMaxLen, InitialDeque)
    end.

max_kept_elements_loop(_X, [], MaxLen, _Deque) -> MaxLen;
max_kept_elements_loop(X, [CurrentNum|T], CurrentMaxLen, Deque) ->
    % Step 1: Remove elements from the front of the deque
    % These are elements `ElemVal` such that `CurrentNum - ElemVal > X`
    % or `ElemVal < CurrentNum - X`.
    TargetVal = CurrentNum - X,
    UpdatedDeque = remove_from_front(TargetVal, Deque),

    % Step 2: Calculate CurrentDP (max length of subsequence ending with CurrentNum)
    % CurrentDP is 1 (if CurrentNum starts a new subsequence)
    % OR 1 + DPValue of a suitable previous element from the deque.
    DPValFromDeque = case queue:peek(UpdatedDeque) of
                         {value, {Val, _}} -> Val;
                         _ -> 0
                     end,
    NewCurrentDP = max(1, DPValFromDeque + 1), % Always at least 1

    % Step 3: Update overall MaxLen
    NewMaxLen = max(CurrentMaxLen, NewCurrentDP),

    % Step 4: Add NewCurrentDP to the back of the deque, maintaining monotonicity
    FinalDeque = add_to_back(NewCurrentDP, CurrentNum, UpdatedDeque),

    max_kept_elements_loop(X, T, NewMaxLen, FinalDeque).

remove_from_front(TargetVal, Deque) ->
    case queue:peek(Deque) of
        {value, {_DPVal, ElemVal}} when ElemVal < TargetVal ->
            remove_from_front(TargetVal, queue:drop(Deque));
        _ ->
            Deque
    end.

add_to_back(CurrentDP, CurrentNum, Deque) ->
    case queue:peek_r(Deque) of
        {value, {LastDPVal, _}} when LastDPVal =< CurrentDP ->
            add_to_back(CurrentDP, CurrentNum, queue:drop_r(Deque));
        _ ->
            queue:in({CurrentDP, CurrentNum}, Deque)
    end.