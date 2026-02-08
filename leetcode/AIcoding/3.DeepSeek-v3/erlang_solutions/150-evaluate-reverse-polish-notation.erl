-spec eval_rpn(Tokens :: [unicode:unicode_binary()]) -> integer().
eval_rpn(Tokens) ->
    eval_rpn(Tokens, []).

eval_rpn([], [Num]) ->
    Num;
eval_rpn([Token | Tokens], Stack) ->
    case is_operator(Token) of
        true ->
            [B, A | Rest] = Stack,
            Op = binary_to_list(Token),
            Res = apply_op(A, B, Op),
            eval_rpn(Tokens, [Res | Rest]);
        false ->
            Num = binary_to_integer(Token),
            eval_rpn(Tokens, [Num | Stack])
    end.

is_operator(<<"+">>) -> true;
is_operator(<<"-">>) -> true;
is_operator(<<"*">>) -> true;
is_operator(<<"/">>) -> true;
is_operator(_) -> false.

apply_op(A, B, "+") -> A + B;
apply_op(A, B, "-") -> A - B;
apply_op(A, B, "*") -> A * B;
apply_op(A, B, "/") -> trunc(A / B).