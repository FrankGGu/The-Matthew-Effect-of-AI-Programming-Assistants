-module(solution).
-export([angle_clock/2]).

angle_clock(Hour, Minutes) ->
    % Convert inputs to floats for precise calculations
    M = float(Minutes),

    % Calculate minute hand angle
    % 6 degrees per minute
    MinuteAngle = M * 6.0,

    % Calculate hour hand angle
    % The hour hand moves 30 degrees per hour (360 / 12)
    % It also moves 0.5 degrees per minute (30 / 60)
    % (Hour rem 12) correctly handles 12 o'clock as 0 for calculation
    HourAngle = (float(Hour rem 12) * 30.0) + (M * 0.5),

    % Calculate the absolute difference between the two angles
    Diff = abs(MinuteAngle - HourAngle),

    % The smaller angle is either Diff or 360 - Diff
    math:min(Diff, 360.0 - Diff).