-module(basic_calculator).
-export([calculate/1]).

calculate(Str) ->
    {Result, _} = parse(Str, 0, 0, 1, []),
    Result.

parse([], Acc, Num, Sign, Stack) ->
    Acc + Sign * Num;
parse([C | Rest], Acc, Num, Sign, Stack) when C >= $0, C =< $9 ->
    parse(Rest, Acc, Num * 10 + (C - $0), Sign, Stack);
parse([C | Rest], Acc, Num, Sign, Stack) when C == $+ ->
    parse(Rest, Acc + Sign * Num, 0, 1, Stack);
parse([C | Rest], Acc, Num, Sign, Stack) when C == $- ->
    parse(Rest, Acc + Sign * Num, 0, -1, Stack);
parse([C | Rest], Acc, Num, Sign, Stack) when C == $() ->
    parse(Rest, 0, 0, 1, [Acc, Sign | Stack]);
parse([C | Rest], Acc, Num, Sign, [PrevAcc, PrevSign | StackTail]) when C == $) ->
    parse(Rest, PrevAcc + PrevSign * (Acc + Sign * Num), 0, 1, StackTail);
parse([_ | Rest], Acc, Num, Sign, Stack) ->
    parse(Rest, Acc, Num, Sign, Stack).