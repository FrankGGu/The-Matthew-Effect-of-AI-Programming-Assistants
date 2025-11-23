-module(new_21_game).
-export([new21Game/3]).

new21Game(N, K, MaxPts) ->
    % Handle K=0 edge case: Alice starts with 0 points. If K=0, she stops immediately.
    % Her score is 0. Since 0 <= N is always true by constraints (0 <= N <= 10^4),
    % the condition K <= S <= N (0 <= 0 <= N) is always met.
    if K == 0 ->
        1.0;
    true ->
        % dp array to store probabilities. dp[i] is the probability of Alice having exactly i points.
        % Using Erlang's array module for efficient random access.
        % Array is 0-indexed, so size N+1 for scores 0 to N.
        DP = array:new([{size, N + 1}, {fixed, true}, {default, 0.0}]),

        % Base case: Alice starts with 0 points with probability 1.0
        DP1 = array:set(0, 1.0, DP),

        % CurrentWindowSum is the sum of dp[j] for j in the range [max(0, i - MaxPts), K - 1].
        % This sum represents the total probability of scores Alice could have had
        % just before drawing a card to reach score 'i', such that she was still playing.
        % Initially, for i=1, the window includes dp[0] (since 0 < K and 0 is reachable).
        CurrentWindowSum = 1.0, 

        % Ans accumulates probabilities for scores I where K <= I <= N.
        Ans = 0.0,

        % Iterate for I from 1 to N
        {_FinalDP, _FinalCurrentWindowSum, FinalAns} = lists:foldl(
            fun(I, {AccDP, AccCurrentWindowSum, AccAns}) ->
                % 1. Calculate dp[I]: Probability of reaching score I.
                %    This is the sum of probabilities of previous valid scores (AccCurrentWindowSum)
                %    divided by the number of possible card values (MaxPts).
                ProbI = AccCurrentWindowSum / MaxPts,
                NewAccDP = array:set(I, ProbI, AccDP),

                % 2. If I is a stopping score (I >= K), add dp[I] to the final answer.
                NewAccAns = if
                    I >= K ->
                        AccAns + ProbI;
                    true ->
                        AccAns
                end,

                % 3. Update CurrentWindowSum for the next iteration (I+1):
                %    a. Remove dp[I - MaxPts] if it falls out of the sliding window
                %       and was a score where Alice was still playing (i.e., < K).
                SumAfterRemoval = if
                    I - MaxPts >= 0 andalso I - MaxPts < K ->
                        AccCurrentWindowSum - array:get(I - MaxPts, AccDP);
                    true ->
                        AccCurrentWindowSum
                end,

                %    b. Add dp[I] to CurrentWindowSum if I is a score where Alice is still playing (I < K).
                SumAfterAddition = if
                    I < K ->
                        SumAfterRemoval + ProbI;
                    true ->
                        SumAfterRemoval
                end,

                {NewAccDP, SumAfterAddition, NewAccAns}
            end,
            {DP1, CurrentWindowSum, Ans},
            lists:seq(1, N)
        ),
        FinalAns
    end.