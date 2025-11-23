-module(solution).
-export([count_days_spent_together/4]).

-define(CUMULATIVE_DAYS, [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]).

parse_date(DateStr) ->
    [MonthStr, DayStr] = string:split(DateStr, "-", all),
    {list_to_integer(MonthStr), list_to_integer(DayStr)}.

day_of_year({Month, Day}) ->
    lists:nth(Month, ?CUMULATIVE_DAYS) + Day.

count_days_spent_together(ArrivalAlice, DepartureAlice, ArrivalBob, DepartureBob) ->
    AliceArrivalDay = day_of_year(parse_date(ArrivalAlice)),
    AliceDepartureDay = day_of_year(parse_date(DepartureAlice)),

    BobArrivalDay = day_of_year(parse_date(ArrivalBob)),
    BobDepartureDay = day_of_year(parse_date(DepartureBob)),

    OverlapStart = max(AliceArrivalDay, BobArrivalDay),
    OverlapEnd = min(AliceDepartureDay, BobDepartureDay),

    max(0, OverlapEnd - OverlapStart + 1).