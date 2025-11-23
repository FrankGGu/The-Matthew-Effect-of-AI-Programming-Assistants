-module(solution).
-export([calculate/1]).

calculate(S) ->
    Chars = string:to_list(S),
    FinalStack = calculate_iter(Chars ++ [$+], 0, $+, []),
    lists:sum(FinalStack).

calculate_iter([], _CurrentNum, _LastOp, Stack) ->
    Stack;
calculate_iter([H|T], CurrentNum, LastOp, Stack) when H >= $0, H =< $9 ->
    NewCurrentNum = CurrentNum * 10 + (H - $0),
    calculate_iter(T, NewCurrentNum, LastOp, Stack);
calculate_iter([H|T], CurrentNum, LastOp, Stack) when H == $  ->
    calculate_iter(T, CurrentNum, LastOp, Stack);
calculate_iter([H|T], CurrentNum, LastOp, Stack) -> % Operator
    NewStack =
        case LastOp of
            $+ -> [CurrentNum | Stack];
            $- -> [-CurrentNum | Stack];
            $* ->
                [Top | Rest] = Stack,
                [Top * CurrentNum | Rest];
            $/ ->
                [Top | Rest] = Stack,
                [Top div CurrentNum | Rest]
        end,
    calculate_iter(T, 0, H, NewStack).