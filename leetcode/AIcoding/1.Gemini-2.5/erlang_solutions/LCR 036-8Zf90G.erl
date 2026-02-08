-module(solution).
-export([eval_rpn/1]).

eval_rpn(Tokens) ->
    eval_rpn_acc(Tokens, []).

eval_rpn_acc([], [Result]) ->
    Result;
eval_rpn_acc([Token | RestTokens], Stack) ->
    case is_operator(Token) of
        true ->
            [Val2 | [Val1 | RestStack]] = Stack,
            Result = apply_op(Token, Val1, Val2),
            eval_rpn_acc(RestTokens, [Result | RestStack]);
        false ->
            Num = list_to_integer(Token),
            eval_rpn_acc(RestTokens, [Num | Stack])
    end.

is_operator(Token) ->
    Token == "+" orelse
    Token == "-" orelse
    Token == "*" orelse
    Token == "/".

apply_op("+", Val1, Val2) -> Val1 + Val2;
apply_op("-", Val1, Val2) -> Val1 - Val2;
apply_op("*", Val1, Val2) -> Val1 * Val2;
apply_op("/", Val1, Val2) -> Val1 div Val2.