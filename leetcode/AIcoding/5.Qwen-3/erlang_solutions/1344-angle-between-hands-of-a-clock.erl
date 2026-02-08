-module(solution).
-export([angle_between_hands/2]).

angle_between_hands(Hour, Minute) ->
    HourAngle = (Hour rem 12) * 30 + (Minute * 0.5),
    MinuteAngle = Minute * 6,
    Diff = abs(HourAngle - MinuteAngle),
    if
        Diff > 180 -> 360 - Diff;
        true -> Diff
    end.