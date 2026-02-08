-module(count_days_spent_together).
-export([countDaysTogether/2]).

countDaysTogether(AB, CD) ->
    A = parse_date(AB),
    B = parse_date(BD),
    C = parse_date(CD),
    D = parse_date(DD),
    DaysA = days_between(A, B),
    DaysC = days_between(C, D),
    Common = common_days(DaysA, DaysC),
    length(Common).

parse_date(Date) ->
    [Y, M, D] = string:split(Date, "-"),
    {list_to_integer(Y), list_to_integer(M), list_to_integer(D)}.

days_between({Y1, M1, D1}, {Y2, M2, D2}) ->
    Date1 = erlang:date_to_gregorian_days({Y1, M1, D1}),
    Date2 = erlang:date_to_gregorian_days({Y2, M2, D2}),
    if
        Date1 > Date2 -> [];
        true -> lists:seq(Date1, Date2)
    end.

common_days(List1, List2) ->
    Set1 = sets:from_list(List1),
    Set2 = sets:from_list(List2),
    sets:intersection(Set1, Set2).

BD = string:split(AB, " "),
CD = string:split(CD, " "),
DD = string:split(CD, " ").