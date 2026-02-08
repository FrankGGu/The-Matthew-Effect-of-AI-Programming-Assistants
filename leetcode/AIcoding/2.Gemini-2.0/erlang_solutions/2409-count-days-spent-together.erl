-module(count_days_together).
-export([solve/0]).

solve() ->
    ArriveAlice = "08-15",
    LeaveAlice = "08-18",
    ArriveBob = "08-16",
    LeaveBob = "08-19",
    io:format("~p~n", [count_days_together(ArriveAlice, LeaveAlice, ArriveBob, LeaveBob)]).

count_days_together(ArriveAlice, LeaveAlice, ArriveBob, LeaveBob) ->
    A1 = string:split(ArriveAlice, "-", all),
    A2 = string:split(LeaveAlice, "-", all),
    B1 = string:split(ArriveBob, "-", all),
    B2 = string:split(LeaveBob, "-", all),

    {A1M, _} = string:to_integer(lists:nth(1, A1)),
    {A1D, _} = string:to_integer(lists:nth(2, A1)),
    {A2M, _} = string:to_integer(lists:nth(1, A2)),
    {A2D, _} = string:to_integer(lists:nth(2, A2)),
    {B1M, _} = string:to_integer(lists:nth(1, B1)),
    {B1D, _} = string:to_integer(lists:nth(2, B1)),
    {B2M, _} = string:to_integer(lists:nth(1, B2)),
    {B2D, _} = string:to_integer(lists:nth(2, B2)),

    ArriveA = days_from_start(A1M, A1D),
    LeaveA = days_from_start(A2M, A2D),
    ArriveB = days_from_start(B1M, B1D),
    LeaveB = days_from_start(B2M, B2D),

    Start = max(ArriveA, ArriveB),
    End = min(LeaveA, LeaveB),

    if Start > End then
        0
    else
        End - Start + 1
    end.

days_from_start(Month, Day) ->
    DaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
    lists:sum(lists:sublist(DaysInMonth, 1, Month - 1)) + Day.