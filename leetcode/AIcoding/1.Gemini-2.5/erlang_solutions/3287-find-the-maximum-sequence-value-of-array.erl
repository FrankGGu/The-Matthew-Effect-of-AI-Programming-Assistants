-module(solution).
-export([max_sequence_value/1]).

max_sequence_value(Nums) ->
    % A sufficiently small number to represent negative infinity.
    % Max possible value is around 10^5 * 10^9 = 10^14.
    % Min possible value is around -10^5 * 10^9 = -10^14.
    % This value needs to be smaller than any possible sequence value.
    MinInt = -2000000000000000000, % -2 * 10^18

    % State is a tuple: {MaxOverallValue, MaxPlusEndingPrev, MaxMinusEndingPrev}
    % MaxOverallValue: The maximum sequence value found across all subsequences processed so far.
    % MaxPlusEndingPrev: The maximum sequence value ending with a positive term (e.g., ... + nums[j]).
    % MaxMinusEndingPrev: The maximum sequence value ending with a negative term (e.g., ... - nums[j]).
    InitialState = {MinInt, MinInt, MinInt},

    {ResultMaxVal, _, _} = lists:foldl(
        fun(X, {AccMaxVal, AccMaxPlusEndingPrev, AccMaxMinusEndingPrev}) ->
            % Calculate CurrentPlusVal: Max value of a sequence ending with +X
            % Option 1: Start a new sequence with X. Value is X.
            % Option 2: Extend a previous sequence that ended with a negative term. Value is X + AccMaxMinusEndingPrev.
            % If AccMaxMinusEndingPrev is MinInt, X + MinInt will be effectively -infinity,
            % so max(X, X + MinInt) correctly resolves to X.
            CurrentPlusVal = max(X, X + AccMaxMinusEndingPrev),

            % Calculate CurrentMinusVal: Max value of a sequence ending with -X
            % Option 1: Extend a previous sequence that ended with a positive term. Value is -X + AccMaxPlusEndingPrev.
            % If AccMaxPlusEndingPrev is MinInt, -X + MinInt will be effectively -infinity,
            % indicating that no valid sequence ending with +term existed to extend.
            CurrentMinusVal = -X + AccMaxPlusEndingPrev,

            % Update the overall maximum sequence value found so far.
            % It can be the previous overall max, or one of the current values.
            NewAccMaxVal = max(AccMaxVal, max(CurrentPlusVal, CurrentMinusVal)),

            % Update MaxPlusEndingPrev for the next iteration.
            % It's the maximum of its previous value and the CurrentPlusVal.
            NewAccMaxPlusEndingPrev = max(AccMaxPlusEndingPrev, CurrentPlusVal),

            % Update MaxMinusEndingPrev for the next iteration.
            % It's the maximum of its previous value and the CurrentMinusVal.
            NewAccMaxMinusEndingPrev = max(AccMaxMinusEndingPrev, CurrentMinusVal),

            {NewAccMaxVal, NewAccMaxPlusEndingPrev, NewAccMaxMinusEndingPrev}
        end,
        InitialState,
        Nums
    ),
    ResultMaxVal.