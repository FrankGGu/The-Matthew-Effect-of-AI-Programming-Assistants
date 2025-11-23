-module(solution).
-export([min_operations/2]).

min_operations(CurrentTime, CorrectTime) ->
    {CurrentHours, CurrentMinutes} = parse_time(CurrentTime),
    {CorrectHours, CorrectMinutes} = parse_time(CorrectTime),
    CurrentTotalMinutes = CurrentHours * 60 + CurrentMinutes,
    CorrectTotalMinutes = CorrectHours * 60 + CorrectMinutes,
    Diff = abs(CorrectTotalMinutes - CurrentTotalMinutes),
    ops(Diff).

parse_time(Time) ->
    [H, M] = string:tokens(Time, ":"),
    {list_to_integer(H), list_to_integer(M)}.

ops(Diff) when Diff == 0 -> 0;
ops(Diff) -> 
    Div60 = Diff div 60,
    Rem60 = Diff rem 60,
    Div15 = Rem60 div 15,
    Rem15 = Rem60 rem 15,
    Div5 = Rem15 div 5,
    Rem5 = Rem15 rem 5,
    Div1 = Rem5,
    Div60 + Div15 + Div5 + Div1.