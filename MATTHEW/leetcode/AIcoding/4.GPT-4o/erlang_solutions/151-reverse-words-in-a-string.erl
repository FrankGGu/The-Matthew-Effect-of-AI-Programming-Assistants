-spec eval_rpn(Tokens :: [unicode:unicode_binary()]) -> integer().
eval_rpn(Tokens) ->
    eval_rpn(Tokens, []).

eval_rpn([], [Result]) -> Result;
eval_rpn([Token | Rest], Stack) ->
    case Token of
        "+" -> 
            [B, A | T] = Stack,
            eval_rpn(Rest, [A + B | T]);
        "-" -> 
            [B, A | T] = Stack,
            eval_rpn(Rest, [A - B | T]);
        "*" -> 
            [B, A | T] = Stack,
            eval_rpn(Rest, [A * B | T]);
        "/" -> 
            [B, A | T] = Stack,
            eval_rpn(Rest, [A div B | T]);
        _ -> 
            eval_rpn(Rest, [list_to_integer(Token) | Stack])
    end.
