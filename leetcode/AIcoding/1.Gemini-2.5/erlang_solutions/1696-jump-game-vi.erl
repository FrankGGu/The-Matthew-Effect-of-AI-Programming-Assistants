-module(solution).
-export([max_result/2]).

max_result(Nums, K) ->
    N = length(Nums),

    % Nums list to array for O(1) access
    NumsArray = array:from_list(Nums),

    % DP array to store maximum scores to reach each index
    % Initialize dp with 0s, size N
    DP = array:new([{size, N}, {fixed, true}]),

    % Base case: dp[0] = Nums[0]
    FirstNum = array:get(0, NumsArray),
    DP1 = array:set(0, FirstNum, DP),

    % Deque (implemented using queue module) will store {Score, Index} tuples.
    % It maintains indices `j` such that `dp[j]` values are in decreasing order.
    % Initialize deque with {dp[0], 0}
    Deque = queue:in({FirstNum, 0}, queue:new()),

    % Iterate from index 1 to N-1
    % Use a recursive helper function to pass state (DP array and Deque)
    solve(1, N, NumsArray, K, DP1, Deque).

solve(N, N, _NumsArray, _K, DP, _Deque) ->
    % All indices processed, return dp[N-1]
    array:get(N - 1, DP);
solve(Idx, N, NumsArray, K, AccDP, AccDeque) ->
    % 1. Remove elements from the front of the deque that are out of window [Idx-K, Idx-1]
    CleanedDeque = remove_out_of_window(AccDeque, Idx, K),

    % 2. The maximum score to jump from is at the head of the deque
    % queue:peek_front returns {value, Element} or empty
    {value, {MaxPrevScore, _MaxPrevIdx}} = queue:peek_front(CleanedDeque),

    % 3. Calculate current_score = Nums[Idx] + MaxPrevScore
    CurrentNum = array:get(Idx, NumsArray),
    CurrentScore = CurrentNum + MaxPrevScore,

    % 4. Update DP array
    NewDP = array:set(Idx, CurrentScore, AccDP),

    % 5. Add current_score to deque, maintaining decreasing order
    NewDeque = add_to_deque(CleanedDeque, CurrentScore, Idx),

    % Recurse for the next index
    solve(Idx + 1, N, NumsArray, K, NewDP, NewDeque).

remove_out_of_window(Deque, CurrentIdx, K) ->
    case queue:peek_front(Deque) of
        {value, {_Score, HeadIdx}} when HeadIdx < CurrentIdx - K ->
            {value, _Element, RestDeque} = queue:out(Deque),
            remove_out_of_window(RestDeque, CurrentIdx, K);
        _ -> Deque
    end.

add_to_deque(Deque, NewScore, NewIdx) ->
    case queue:peek_back(Deque) of
        {value, {TailScore, _TailIdx}} when TailScore =< NewScore ->
            {value, _Element, RestDeque} = queue:drop_last(Deque), % drop_last removes from back
            add_to_deque(RestDeque, NewScore, NewIdx);
        _ ->
            queue:in({NewScore, NewIdx}, Deque) % Add to back
    end.