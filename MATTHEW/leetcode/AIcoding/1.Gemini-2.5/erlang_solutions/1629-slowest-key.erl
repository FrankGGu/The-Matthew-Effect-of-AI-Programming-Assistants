-module(slowest_key).
-export([slowestKey/1]).

slowestKey(KeyTimes) ->
    % Destructure the first element and the rest of the list
    [{InitialKeyChar, InitialTime} | RestKeyTimes] = KeyTimes,

    % The duration of the first key press is its release time (t0)
    InitialDuration = InitialTime,

    % Use lists:foldl to iterate through the rest of the key presses
    % The accumulator stores {MaxDurationFoundSoFar, SlowestKeyCharFoundSoFar, PreviousReleaseTime}
    {_FinalMaxDuration, FinalSlowestKeyChar, _FinalPreviousTime} = 
        lists:foldl(
            fun({CurrentKeyChar, CurrentTime}, {AccMaxDuration, AccSlowestKeyChar, AccPreviousTime}) ->
                % Calculate the duration for the current key press
                CurrentDuration = CurrentTime - AccPreviousTime,

                % Compare current duration with the maximum duration found so far
                if 
                    CurrentDuration > AccMaxDuration ->
                        % If current duration is strictly greater, update max duration and slowest key
                        {CurrentDuration, CurrentKeyChar, CurrentTime};
                    CurrentDuration == AccMaxDuration ->
                        % If durations are equal, choose the lexicographically largest key
                        if 
                            CurrentKeyChar > AccSlowestKeyChar ->
                                {CurrentDuration, CurrentKeyChar, CurrentTime};
                            true -> % Keep the existing slowest key if current is not greater
                                {AccMaxDuration, AccSlowestKeyChar, CurrentTime}
                        end;
                    true -> % CurrentDuration < AccMaxDuration, keep existing max duration and key
                        {AccMaxDuration, AccSlowestKeyChar, CurrentTime}
                end
            end,
            % Initial accumulator state derived from the first key press
            {InitialDuration, InitialKeyChar, InitialTime},
            RestKeyTimes
        ),

    % Return the character of the slowest key
    FinalSlowestKeyChar.