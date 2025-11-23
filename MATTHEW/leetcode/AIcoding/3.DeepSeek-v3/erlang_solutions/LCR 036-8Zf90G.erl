evalRPN(Tokens) ->
    Stack = [],
    lists:foldl(fun
        ("+", [A, B | Rest]) -> [B + A | Rest];
        ("-", [A, B | Rest]) -> [B - A | Rest];
        ("*", [A, B | Rest]) -> [B * A | Rest];
        ("/", [A, B | Rest]) -> [B div A | Rest];
        (Token, StackAcc) -> [list_to_integer(Token) | StackAcc]
    end, Stack, Tokens),
    hd(Stack).