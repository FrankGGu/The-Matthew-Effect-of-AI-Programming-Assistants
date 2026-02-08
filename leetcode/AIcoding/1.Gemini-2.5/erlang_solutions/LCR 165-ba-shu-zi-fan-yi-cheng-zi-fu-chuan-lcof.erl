-module(solution).
-export([decode_ways/1]).

decode_ways(NumStr) ->
    Len = length(NumStr),
    case Len of
        0 -> 1; % An empty string has one way to be decoded (no digits, no choices)
        _ ->
            Digits = [C - $0 || C <- NumStr], % Convert string to a list of integers
            FirstDigit = hd(Digits),

            % dp_i_minus_2 represents the number of ways to decode the prefix of length i-2.
            % Initial value: dp[0] = 1 (representing an empty prefix, 1 way to decode)
            Prev2 = 1, 

            % dp_i_minus_1 represents the number of ways to decode the prefix of length i-1.
            % Initial value: dp[1] = 1 if the first digit is not '0', otherwise 0.
            Prev1 = case FirstDigit of
                        0 -> 0;
                        _ -> 1
                    end,

            % Start the recursive process from the second digit.
            % The state passed is (RemainingDigits, PreviousDigit, dp[i-2], dp[i-1]).
            loop(tl(Digits), FirstDigit, Prev2, Prev1)
    end.

loop([], _LastDigit, _Prev2, Prev1) ->
    Prev1;
loop([CurrentDigit | RestDigits], PrevDigit, Prev2, Prev1) ->
    % Calculate ways if CurrentDigit is decoded as a single digit.
    % If CurrentDigit is '0', it cannot be decoded alone, so 0 ways.
    % Otherwise, it adds dp[i-1] (Prev1) ways.
    WaysFromSingleDigit = case CurrentDigit of
                              0 -> 0;
                              _ -> Prev1
                          end,

    % Calculate ways if PrevDigit and CurrentDigit are decoded as a two-digit number.
    % Form the two-digit number.
    TwoDigitNum = PrevDigit * 10 + CurrentDigit,

    % If the two-digit number is between 10 and 26 (inclusive), it's a valid decoding.
    % This adds dp[i-2] (Prev2) ways.
    WaysFromTwoDigits = case (TwoDigitNum >= 10 andalso TwoDigitNum <= 26) of
                            true -> Prev2;
                            false -> 0
                        end,

    % Total ways for the current prefix (dp[i]) is the sum of ways from single and two-digit decodings.
    NewCurrentWays = WaysFromSingleDigit + WaysFromTwoDigits,

    % Recurse for the next digit:
    % - CurrentDigit becomes the new PrevDigit for the next step.
    % - Prev1 (old dp[i-1]) becomes the new Prev2 (for dp[i-1] in next step).
    % - NewCurrentWays (dp[i]) becomes the new Prev1 (for dp[i] in next step).
    loop(RestDigits, CurrentDigit, Prev1, NewCurrentWays).