-module(basic_calculator_ii).
-export([calculate/1]).

calculate(Str) ->
    calculate(Str, 0, 0, 1, $+).

calculate([], Num, Stack, Sign, _) ->
    case Sign of
        $+ -> Num + Stack;
        $- -> -Num + Stack;
        $* -> Num * Stack;
        $/ -> trunc(Num / Stack)
    end;
calculate([C | Rest], Num, Stack, Sign, Op) when C >= $0, C =< $9 ->
    calculate(Rest, Num * 10 + (C - $0), Stack, Sign, Op);
calculate([C | Rest], Num, Stack, Sign, Op) when C == $+; C == $-; C == $*; C == $/ ->
    NewStack = case Op of
        $+ -> Stack + Num;
        $- -> Stack - Num;
        $* -> Stack * Num;
        $/ -> trunc(Stack / Num)
    end,
    calculate(Rest, 0, NewStack, C, C);
calculate([C | Rest], Num, Stack, Sign, Op) ->
    calculate(Rest, Num, Stack, Sign, Op).