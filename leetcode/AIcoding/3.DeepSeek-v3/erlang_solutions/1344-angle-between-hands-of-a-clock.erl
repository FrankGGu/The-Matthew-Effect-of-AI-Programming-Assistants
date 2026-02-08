-spec angle_clock(Hour :: integer(), Minutes :: integer()) -> float().
angle_clock(Hour, Minutes) ->
    HourAngle = (Hour rem 12) * 30 + Minutes * 0.5,
    MinuteAngle = Minutes * 6,
    Angle = abs(HourAngle - MinuteAngle),
    min(Angle, 360 - Angle).