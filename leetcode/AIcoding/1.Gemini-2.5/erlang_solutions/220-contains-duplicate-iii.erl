-module(solution).
-export([containsDuplicateIII/3]).

containsDuplicateIII(Nums, K, T) ->
    % Nums: original list of integers
    % K: maximum absolute difference between indices
    % T: maximum absolute difference between values
    % Index: current index being processed (0-based)
    % WindowMap: map of BucketID -> Value for numbers currently in the sliding window
    % WindowQueue: queue of values in the sliding window, used to remove old elements in FIFO order
    containsDuplicateIII_impl(Nums, K, T, 0, maps:new(), queue:new()).

containsDuplicateIII_impl([], _K, _T, _Index, _WindowMap, _WindowQueue) ->
    false; % No more numbers to process, no duplicate found
containsDuplicateIII_impl([H | Tail], K, T, Index, WindowMap, WindowQueue) ->
    BucketSize = T + 1, % Size of each bucket
    BucketID = floor_div(H, BucketSize), % Calculate bucket ID for the current number H

    % Check if a duplicate exists in the current bucket or adjacent buckets
    case check_for_duplicate(H, T, BucketID, WindowMap) of
        true -> true; % Duplicate found, return true
        false ->
            % No duplicate found, proceed to update the window
            NewWindowMap = maps:put(BucketID, H, WindowMap), % Add current number to its bucket
            NewWindowQueue = queue:in(H, WindowQueue), % Add current number to the queue

            % Remove the oldest element if the window size exceeds K
            remove_old_element(K, T, Index, NewWindowMap, NewWindowQueue, Tail)
    end.

check_for_duplicate(H, T, BucketID, WindowMap) ->
    % Check current bucket
    (case maps:find(BucketID, WindowMap) of
        {ok, Val} -> abs(Val - H) =< T;
        error -> false
    end) orelse % Short-circuit OR
    % Check BucketID - 1 (previous bucket)
    (case maps:find(BucketID - 1, WindowMap) of
        {ok, PrevVal} -> abs(PrevVal - H) =< T;
        error -> false
    end) orelse % Short-circuit OR
    % Check BucketID + 1 (next bucket)
    (case maps:find(BucketID + 1, WindowMap) of
        {ok, NextVal} -> abs(NextVal - H) =< T;
        error -> false
    end).

remove_old_element(K, T, Index, WindowMap, WindowQueue, Tail) ->
    if Index >= K -> % If current index is K or more, the window is full, remove oldest
        {OldVal, UpdatedWindowQueue} = queue:out(WindowQueue), % Get and remove oldest element from queue
        OldBucketSize = T + 1,
        OldBucketID = floor_div(OldVal, OldBucketSize),

        % Only remove OldBucketID from the map if OldVal is still the one stored in that bucket.
        % This handles cases where a newer value might have overwritten OldVal's bucket entry.
        UpdatedWindowMap = case maps:find(OldBucketID, WindowMap) of
                               {ok, OldVal} -> maps:remove(OldBucketID, WindowMap);
                               _ -> WindowMap % Either not found, or a different value is there
                           end,
        containsDuplicateIII_impl(Tail, K, T, Index + 1, UpdatedWindowMap, UpdatedWindowQueue);
    true -> % Window not yet full, no removal needed
        containsDuplicateIII_impl(Tail, K, T, Index + 1, WindowMap, WindowQueue)
    end.

floor_div(X, Y) ->
    Q = X div Y,
    R = X rem Y,
    if
        R == 0 -> Q; % No remainder, standard division is floor
        (X > 0 and Y > 0) or (X < 0 and Y < 0) -> Q; % Same signs, standard division is floor
        true -> Q - 1 % Different signs and non-zero remainder, adjust by subtracting 1
    end.