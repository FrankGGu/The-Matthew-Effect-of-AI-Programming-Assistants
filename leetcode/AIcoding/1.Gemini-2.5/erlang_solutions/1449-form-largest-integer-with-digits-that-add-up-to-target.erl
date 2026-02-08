-module(solution).
-export([largest_integer/2]).

largest_integer(Cost, Target) ->
    % dp[i] stores {Length, LastDigit, PrevTarget}
    % Length: length of the string
    % LastDigit: the digit (1-9) that was appended last to reach this state
    % PrevTarget: the target value from which this state was reached (i - cost[LastDigit])
    % Initialize dp array with Target + 1 elements
    % dp[0] = {0, 0, 0} (length 0, no digit, no prev target, serves as base for reconstruction)
    % dp[i] = {-1, 0, 0} for i > 0, indicating no valid string can be formed yet (length -1)
    Dp = array:new([{size, Target + 1}, {default, {-1, 0, 0}}]),
    Dp0 = array:set(0, {0, 0, 0}, Dp),

    % Iterate through possible target values from 1 to Target
    ResultDp = lists:foldl(
        fun(I, CurrentDp) ->
            % For each target I, try to append each digit (9 down to 1)
            % Iterating digits from 9 down to 1 ensures that for equal string lengths,
            % the lexicographically largest string is chosen.
            lists:foldl(
                fun(Digit, InnerDp) ->
                    % Cost for the current digit
                    % Cost list is 1-indexed for digits 1-9
                    C = lists:nth(Digit, Cost),

                    % If current target I is at least the cost C
                    % and a valid state exists for target (I - C)
                    if I >= C ->
                        {PrevLen, _, _} = array:get(I - C, InnerDp),
                        if PrevLen /= -1 -> % Check if a valid string exists for I - C
                            NewLen = PrevLen + 1,

                            {CurrentLen, CurrentDigit, _} = array:get(I, InnerDp),

                            % Compare the new candidate string with the current best string for target I
                            % We want the largest string:
                            % 1. Longer string is preferred (NewLen > CurrentLen)
                            % 2. If lengths are equal (NewLen == CurrentLen),
                            %    a larger 'LastDigit' is preferred because we iterate digits 9->1.
                            %    If NewLen == CurrentLen and Digit > CurrentDigit, update.
                            %    If NewLen == CurrentLen and Digit == CurrentDigit, it means the prefixes
                            %    are the same and the last digit is the same, so no update needed.
                            if NewLen > CurrentLen ->
                                array:set(I, {NewLen, Digit, I - C}, InnerDp);
                            else if NewLen == CurrentLen andalso Digit > CurrentDigit ->
                                array:set(I, {NewLen, Digit, I - C}, InnerDp);
                            else
                                InnerDp % Keep Current state as it's larger or equal
                            end
                            end;
                        true ->
                            InnerDp % No valid string for (I - C), so cannot form for I with this digit
                        end;
                    true ->
                        InnerDp % Cost C is too high for current target I
                    end
                end,
                CurrentDp,
                lists:seq(9, 1, -1) % Iterate digits from 9 down to 1
            )
        end,
        Dp0,
        lists:seq(1, Target) % Iterate targets from 1 to Target
    ),

    % Reconstruct the string from the ResultDp
    FinalStr = reconstruct_string(Target, ResultDp),
    if FinalStr == "" -> % If no string can be formed (including for Target=0)
        "0";
    true ->
        FinalStr
    end.

reconstruct_string(CurrentTarget, Dp) ->
    {Len, Digit, PrevTarget} = array:get(CurrentTarget, Dp),
    if Len == -1 -> % Base case: no string found for this target
        "0";
    Len == 0 -> % Base case: target 0, empty string (prefix for valid results)
        "";
    true ->
        % Recursively reconstruct the prefix and append the current digit
        reconstruct_string(PrevTarget, Dp) ++ integer_to_list(Digit)
    end.