-module(solution).
-export([count_days_spent_together/4]).

count_days_spent_together(Start1, End1, Start2, End2) ->
    Start1Date = parse_date(Start1),
    End1Date = parse_date(End1),
    Start2Date = parse_date(Start2),
    End2Date = parse_date(End2),
    MaxStart = max_date(Start1Date, Start2Date),
    MinEnd = min_date(End1Date, End2Date),
    case date_diff(MaxStart, MinEnd) of
        Days when Days < 0 -> 0;
        Days -> Days + 1
    end.

parse_date(DateString) ->
    [Year, Month, Day] = string:tokens(DateString, "-"),
    {list_to_integer(Year), list_to_integer(Month), list_to_integer(Day)}.

max_date({Y1, M1, D1}, {Y2, M2, D2}) ->
    case {Y1 > Y2, Y1 == Y2, M1 > M2, M1 == M2, D1 > D2} of
        {true, _, _, _, _} -> {Y1, M1, D1};
        {false, true, true, _, _} -> {Y1, M1, D1};
        {false, true, false, _, _} -> {Y2, M2, D2};
        {false, false, _, _, _} -> {Y2, M2, D2}
    end.

min_date({Y1, M1, D1}, {Y2, M2, D2}) ->
    case {Y1 < Y2, Y1 == Y2, M1 < M2, M1 == M2, D1 < D2} of
        {true, _, _, _, _} -> {Y1, M1, D1};
        {false, true, true, _, _} -> {Y1, M1, D1};
        {false, true, false, _, _} -> {Y2, M2, D2};
        {false, false, _, _, _} -> {Y2, M2, D2}
    end.

date_diff({Y1, M1, D1}, {Y2, M2, D2}) ->
    case {Y1, M1, D1} == {Y2, M2, D2} of
        true -> 0;
        false -> days_between({Y1, M1, D1}, {Y2, M2, D2})
    end.

days_between(Start, End) ->
    {Y1, M1, D1} = Start,
    {Y2, M2, D2} = End,
    Days1 = days_in_years(Y1) + days_in_months(Y1, M1) + D1,
    Days2 = days_in_years(Y2) + days_in_months(Y2, M2) + D2,
    Days2 - Days1.

days_in_years(Y) -> 
    lists:sum([if is_leap_year(Y) -> 366; true -> 365 end || Y <- lists:seq(1, Y)]).

days_in_months(Y, M) ->
    lists:sum([days_in_month(Y, Month) || Month <- lists:seq(1, M - 1)]).

days_in_month(Y, M) ->
    case M of
        1 -> 31;
        2 -> if is_leap_year(Y) -> 29; true -> 28 end;
        3 -> 31;
        4 -> 30;
        5 -> 31;
        6 -> 30;
        7 -> 31;
        8 -> 31;
        9 -> 30;
        10 -> 31;
        11 -> 30;
        12 -> 31
    end.

is_leap_year(Y) -> 
    (Y rem 4 == 0 andalso Y rem 100 /= 0) orelse (Y rem 400 == 0).