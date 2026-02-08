-module(angle_between_hands_of_a_clock).
-export([angle_clock/2]).

angle_clock(Hour, Minutes) ->
    HourAngle = (Hour rem 12 + Minutes / 60) * 30,
    MinuteAngle = Minutes * 6,
    Diff = abs(HourAngle - MinuteAngle),
    min(Diff, 360 - Diff).