-module(evaluate_rpn).
-export([eval_rpn/1]).

eval_rpn(Tokens) ->
    eval_rpn(Tokens, []).

eval_rpn([], [Result]) ->
    Result;
eval_rpn([Token | Rest], Stack) ->
    case Token of
        "+" ->
            [B, A | S] = Stack,
            eval_rpn(Rest, [A + B | S]);
        "-" ->
            [B, A | S] = Stack,
            eval_rpn(Rest, [A - B | S]);
        "*" ->
            [B, A | S] = Stack,
            eval_rpn(Rest, [A * B | S]);
        "/" ->
            [B, A | S] = Stack,
            eval_rpn(Rest, [trunc(A / B) | S]);
        _ ->
            {Num, _} = string:to_integer(Token),
            eval_rpn(Rest, [Num | Stack])
    end.