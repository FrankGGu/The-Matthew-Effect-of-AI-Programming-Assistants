-module(solution).
-export([eval_rpn/1]).

eval_rpn(Tokens) ->
    eval_rpn_impl(Tokens, []).

eval_rpn_impl([], [Result]) ->
    Result;
eval_rpn_impl([Token|RestTokens], Stack) ->
    case Token of
        "+" ->
            [Op2, Op1|RestStack] = Stack,
            Result = Op1 + Op2,
            eval_rpn_impl(RestTokens, [Result|RestStack]);
        "-" ->
            [Op2, Op1|RestStack] = Stack,
            Result = Op1 - Op2,
            eval_rpn_impl(RestTokens, [Result|RestStack]);
        "*" ->
            [Op2, Op1|RestStack] = Stack,
            Result = Op1 * Op2,
            eval_rpn_impl(RestTokens, [Result|RestStack]);
        "/" ->
            [Op2, Op1|RestStack] = Stack,
            Result = trunc(Op1 / Op2),
            eval_rpn_impl(RestTokens, [Result|RestStack]);
        _ ->
            Number = list_to_integer(Token),
            eval_rpn_impl(RestTokens, [Number|Stack])
    end.