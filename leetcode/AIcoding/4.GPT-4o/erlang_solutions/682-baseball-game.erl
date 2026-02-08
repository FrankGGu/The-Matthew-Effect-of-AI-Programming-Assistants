-module(solution).
-export([calPoints/1]).

calPoints(Ops) ->
    calPoints(Ops, []).

calPoints([], Stack) ->
    lists:sum(Stack);
calPoints([Op | Rest], Stack) ->
    case Op of
        "+" -> 
            [lists:last(Stack) + lists:nth(length(Stack) - 1, Stack) | Stack];
        "D" -> 
            [2 * lists:last(Stack) | Stack];
        "C" -> 
            tl(Stack);
        _ -> 
            [list_to_integer(Op) | Stack]
    end,
    calPoints(Rest, Stack).