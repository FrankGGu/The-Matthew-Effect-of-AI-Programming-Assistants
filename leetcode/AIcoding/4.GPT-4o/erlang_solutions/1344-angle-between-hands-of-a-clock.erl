-module(solution).
-export([angleBetweenHands/2]).

angleBetweenHands(Hour, Minute) ->
    HourAngle = (Hour rem 12) * 30 + Minute * 0.5,
    MinuteAngle = Minute * 6,
    Angle = abs(HourAngle - MinuteAngle),
    min(Angle, 360 - Angle).