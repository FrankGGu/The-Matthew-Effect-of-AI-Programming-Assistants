-module(solution).
-export([peopleAwareOfSecret/3]).

peopleAwareOfSecret(N, Delay, Forget) ->
    Mod = 1000000007,

    % dp[i] stores the number of people who learn the secret on day i.
    % Array is 0-indexed, but we use 1-indexed days, so size N+1.
    % Initialize dp[1] = 1, others 0.
    Dp = array:new([{size, N + 1}, {default, 0}]),
    Dp1 = array:set(1, 1, Dp),

    % CurrentSharersCount:
    % This variable maintains the sum of dp[k] for k in [Day - Forget + 1, Day - Delay].
    % This sum represents the number of people who are actively sharing the secret on the current 'Day'.
    % For Day > 1, this value will be assigned to dp[Day].
    CurrentSharersCount = 0,

    % Loop through each day from 1 to N to populate the dp array.
    {FinalDp, _} = lists:foldl(
        fun(Day, {AccDp, AccSharersCount}) ->
            % 1. People who learned on Day - Delay days ago start sharing on 'Day'.
            %    Add dp[Day - Delay] to AccSharersCount.
            NewSharersCount1 = 
                if Day - Delay >= 1 ->
                    (AccSharersCount + array:get(Day - Delay, AccDp)) rem Mod;
                true ->
                    AccSharersCount
                end,

            % 2. People who learned on Day - Forget days ago stop sharing on 'Day'.
            %    Subtract dp[Day - Forget] from NewSharersCount1.
            NewSharersCount2 = 
                if Day - Forget >= 1 ->
                    (NewSharersCount1 - array:get(Day - Forget, AccDp) + Mod) rem Mod;
                true ->
                    NewSharersCount1
                end,

            % 3. Calculate dp[Day].
            %    dp[1] is already 1. For Day > 1, dp[Day] is NewSharersCount2.
            NewDp = 
                if Day > 1 ->
                    array:set(Day, NewSharersCount2, AccDp);
                true ->
                    AccDp % For Day 1, dp[1] is initialized to 1.
                end,

            % Pass the updated dp array and sharers count to the next iteration.
            {NewDp, NewSharersCount2}
        end,
        {Dp1, CurrentSharersCount}, % Initial state for foldl: Dp with dp[1]=1, CurrentSharersCount=0
        lists:seq(1, N)
    ),

    % After populating the dp array, calculate the total number of people aware on day N.
    % These are people who learned on day 'k' such that:
    % k + Forget > N (they haven't forgotten yet) => k > N - Forget
    % So, k is in the range (N - Forget, N].
    TotalAware = lists:foldl(
        fun(K, Acc) ->
            (Acc + array:get(K, FinalDp)) rem Mod
        end,
        0,
        % Generate list of K values: max(1, N - Forget + 1) to N
        lists:seq(max(1, N - Forget + 1), N)
    ),

    TotalAware.