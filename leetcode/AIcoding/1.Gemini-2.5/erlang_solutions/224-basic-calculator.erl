-module(solution).
-export([calculate/1]).

calculate(S) ->
    calculate_recursive(S, 0, 1, []).

calculate_recursive([], CurrentResult, _CurrentSign, _Stack) ->
    CurrentResult;
calculate_recursive([C | Rest], CurrentResult, CurrentSign, Stack) ->
    case C of
        $  -> calculate_recursive(Rest, CurrentResult, CurrentSign, Stack);
        $+ -> calculate_recursive(Rest, CurrentResult, 1, Stack);
        $- -> calculate_recursive(Rest, CurrentResult, -1, Stack);
        $( ->
            calculate_recursive(Rest, 0, 1, [{CurrentResult, CurrentSign} | Stack]);
        $) ->
            {PrevResult, PrevSign} = hd(Stack),
            NewStack = tl(Stack),
            calculate_recursive(Rest, PrevResult + CurrentResult * PrevSign, PrevSign, NewStack);
        _ when C >= $0 andalso C <= $9 ->
            {Num, Remaining} = parse_number([C | Rest], 0),
            calculate_recursive(Remaining, CurrentResult + Num * CurrentSign, CurrentSign, Stack);
        _ ->
            calculate_recursive(Rest, CurrentResult, CurrentSign, Stack)
    end.

parse_number([], Acc) -> {Acc, []};
parse_number([C | Rest], Acc) when C >= $0 andalso C <= $9 ->
    parse_number(Rest, Acc * 10 + (C - $0));
parse_number(Chars, Acc) ->
    {Acc, Chars}.