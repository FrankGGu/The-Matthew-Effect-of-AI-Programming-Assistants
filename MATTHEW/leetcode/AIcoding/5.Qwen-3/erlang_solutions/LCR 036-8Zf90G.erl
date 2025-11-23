-module(eval_rpn).
-export([eval_rpn/1]).

eval_rpn(Tokens) ->
    eval_rpn(Tokens, []).

eval_rpn([], [Result]) ->
    Result;
eval_rpn([Token | Rest], Stack) ->
    case Token of
        "+" ->
            [B, A | Tail] = Stack,
            eval_rpn(Rest, [A + B | Tail]);
        "-" ->
            [B, A | Tail] = Stack,
            eval_rpn(Rest, [A - B | Tail]);
        "*" ->
            [B, A | Tail] = Stack,
            eval_rpn(Rest, [A * B | Tail]);
        "/" ->
            [B, A | Tail] = Stack,
            eval_rpn(Rest, [trunc(A / B) | Tail]);
        _ ->
            {Num, _} = string:to_integer(Token),
            eval_rpn(Rest, [Num | Stack])
    end.