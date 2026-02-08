-module(solution).
-export([dayOfTheWeek/3]).

dayOfTheWeek(Day, Month, Year) ->
    % Adjust month and year for Zeller's congruence
    % January and February are treated as months 13 and 14 of the previous year
    {AdjustedMonth, AdjustedYear} =
        if
            Month =:= 1 -> {13, Year - 1};
            Month =:= 2 -> {14, Year - 1};
            true -> {Month, Year}
        end,

    % Zeller's congruence formula:
    % h = (q + floor(13*(m+1)/5) + K + floor(K/4) + floor(J/4) - 2*J) mod 7
    % h: day of week (0=Saturday, 1=Sunday, ..., 6=Friday)
    % q: day of month
    % m: adjusted month (3=March, ..., 14=February)
    % K: year of the century (year mod 100)
    % J: century (floor(year / 100))

    Q = Day,
    M = AdjustedMonth,
    K = AdjustedYear rem 100,
    J = AdjustedYear div 100,

    % Calculate h
    H_numerator = Q + (13 * (M + 1) div 5) + K + (K div 4) + (J div 4) - (2 * J),
    H = H_numerator rem 7,

    % Map H to the desired day names (Sunday=0, Monday=1, ..., Saturday=6)
    % Zeller's H values: 0=Sat, 1=Sun, 2=Mon, 3=Tue, 4=Wed, 5=Thu, 6=Fri
    % Desired mapping:    0=Sun, 1=Mon, 2=Tue, 3=Wed, 4=Thu, 5=Fri, 6=Sat
    % The transformation (H + 6) rem 7 achieves this mapping.
    DesiredIndex = (H + 6) rem 7,

    DaysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],

    % lists:nth is 1-indexed, so we add 1 to DesiredIndex
    lists:nth(DesiredIndex + 1, DaysOfWeek).