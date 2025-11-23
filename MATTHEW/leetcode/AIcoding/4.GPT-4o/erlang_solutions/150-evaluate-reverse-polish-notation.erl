-spec eval_rpn(Tokens :: [unicode:unicode_binary()]) -> integer().
eval_rpn(Tokens) ->
    eval_rpn(Tokens, []).

eval_rpn([], [Result]) -> 
    Result;
eval_rpn([Token | Rest], Stack) when Token == "+" orelse Token == "-" orelse Token == "*" orelse Token == "/" ->
    [Op2, Op1 | RestStack] = Stack,
    Result = apply_operator(Op1, Op2, Token),
    eval_rpn(Rest, [Result | RestStack]);
eval_rpn([Token | Rest], Stack) ->
    eval_rpn(Rest, [list_to_integer(Token) | Stack]).

apply_operator(Op1, Op2, "+") -> Op1 + Op2;
apply_operator(Op1, Op2, "-") -> Op1 - Op2;
apply_operator(Op1, Op2, "*") -> Op1 * Op2;
apply_operator(Op1, Op2, "/") -> trunc(Op1 / Op2).
