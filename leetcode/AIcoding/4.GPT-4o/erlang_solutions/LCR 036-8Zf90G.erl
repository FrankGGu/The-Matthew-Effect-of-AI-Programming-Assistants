-module(solution).
-export([eval_rpn/1]).

eval_rpn(Expr) ->
    eval_rpn(Expr, []).

eval_rpn([], [Result]) ->
    Result;
eval_rpn([H | T], Stack) ->
    case H of
        "+" -> 
            [A, B | Rest] = Stack,
            eval_rpn(T, [B + A | Rest]);
        "-" -> 
            [A, B | Rest] = Stack,
            eval_rpn(T, [B - A | Rest]);
        "*" -> 
            [A, B | Rest] = Stack,
            eval_rpn(T, [B * A | Rest]);
        "/" -> 
            [A, B | Rest] = Stack,
            eval_rpn(T, [B div A | Rest]);
        _ -> 
            eval_rpn(T, [list_to_integer(H) | Stack])
    end.