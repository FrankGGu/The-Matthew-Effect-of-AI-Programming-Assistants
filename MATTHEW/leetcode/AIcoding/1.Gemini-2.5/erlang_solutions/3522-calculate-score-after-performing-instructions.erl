-module(solution).
-export([max_score_after_operations/2]).

max_score_after_operations(NumsList, K) ->
    N = length(NumsList),
    if N == 0 ->
        0;
    true ->
        Nums = array:from_list(NumsList), % Convert list to array for O(1) access
        % Deque stores {Score, Index} pairs, maintaining scores in decreasing order.
        % This allows efficient retrieval of the maximum score in a sliding window.
        Deque = [], % Start with an empty deque. Handle the 0-score base case explicitly.

        % MaxOverallScore tracks the maximum score found so far.
        % Initialize to 0, as picking nothing is an option (resulting in a score of 0).
        calculate_dp(0, N, Nums, K, Deque, 0)
    end.

calculate_dp(I, N, Nums, K, Deque, MaxOverallScore) when I < N ->
    % 1. Remove elements from the front of the deque whose index is too old.
    %    We need max(dp[j]) for j < I - K.
    %    So, remove {_, J} if J < I - K.
    CleanedDeque = lists:dropwhile(fun({_Score, Idx}) -> Idx < I - K end, Deque),

    % 2. Get the maximum previous score from the valid window.
    %    If the deque is empty after cleaning, it means no valid previous picks
    %    (i.e., all previous indices are within the [I-K, I-1] range, or I-K < 0),
    %    so the score from previous picks is 0.
    MaxPrevScore = case CleanedDeque of
                       [] -> 0;
                       [{S, _} | _] -> S % The front of the deque holds the maximum score
                   end,

    % 3. Calculate current dp[I] (maximum score if nums[I] is the last chosen element)
    NumI = array:get(I, Nums), % array is 0-indexed
    CurrentDpI = NumI + MaxPrevScore,

    % 4. Update MaxOverallScore
    %    The overall maximum score could be CurrentDpI, or the MaxOverallScore found so far.
    NewMaxOverallScore = max(MaxOverallScore, CurrentDpI),

    % 5. Add (CurrentDpI, I) to the back of the deque, maintaining monotonicity.
    %    Remove elements from the back whose scores are less than or equal to CurrentDpI.
    %    This ensures the deque remains in decreasing order of scores.
    %    lists:foldr here acts as a reverse iteration with conditional dropping from the end.
    NewDeque = lists:foldr(fun({S, Idx}, Acc) ->
                                    if S > CurrentDpI -> [{S, Idx} | Acc]; % Keep elements with higher scores
                                    true -> Acc                           % Drop elements with lower or equal scores
                                    end
                            end, [{CurrentDpI, I}], CleanedDeque),

    % 6. Recurse for the next index
    calculate_dp(I + 1, N, Nums, K, NewDeque, NewMaxOverallScore);
calculate_dp(_I, _N, _Nums, _K, _Deque, MaxOverallScore) ->
    MaxOverallScore.