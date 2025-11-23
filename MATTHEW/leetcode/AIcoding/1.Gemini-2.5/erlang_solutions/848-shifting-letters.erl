-module(solution).
-export([shifting_letters/2]).

shifting_letters(S, Shifts) ->
    % Reverse the input string and shifts list to process them from right to left
    % using lists:foldl. This allows accumulating the total shift correctly.
    S_rev = lists:reverse(S),
    Shifts_rev = lists:reverse(Shifts),

    % The accumulator for lists:foldl will be a tuple:
    % {CurrentTotalShift, RemainingShiftsRev, ResultChars}
    % CurrentTotalShift: The cumulative shift for the characters processed so far (from right to left).
    % RemainingShiftsRev: The portion of the reversed shifts list yet to be consumed.
    % ResultChars: The list of shifted characters, built in the correct order (S[0]...S[N-1]).
    {_FinalTotalShift, _RemainingShifts, FinalResultChars} = lists:foldl(
        fun(Char, {AccShift, [ShiftVal | RestShiftsRev], ResultAcc}) ->
            % Calculate the new cumulative shift.
            % Modulo 26 ensures it wraps around the alphabet.
            NewAccShift = (AccShift + ShiftVal) rem 26,

            % Calculate the new character.
            % (Char - $a) converts 'a' to 0, 'b' to 1, etc.
            % Add the NewAccShift, then take modulo 26 to wrap.
            % Add $a back to convert the 0-25 value back to an ASCII character.
            ShiftedChar = ((Char - $a + NewAccShift) rem 26) + $a,

            % Return the updated accumulator.
            % Prepending ShiftedChar to ResultAcc builds the list in the correct order (left to right).
            {NewAccShift, RestShiftsRev, [ShiftedChar | ResultAcc]}
        end,
        {0, Shifts_rev, []}, % Initial accumulator: no shift, all shifts remaining, empty result list.
        S_rev
    ),

    % FinalResultChars is already in the correct order, so no final reverse is needed.
    FinalResultChars.