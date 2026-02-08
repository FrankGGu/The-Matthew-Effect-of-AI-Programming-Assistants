-spec add_operators(Num :: unicode:unicode_binary(), Target :: integer()) -> [unicode:unicode_binary()].
add_operators(Num, Target) ->
    lists:reverse(add_operators(Num, Target, [], 0, 0, [])).

add_operators([], Target, ExprAcc, ValAcc, MulAcc, Result) when ValAcc =:= Target ->
    lists:reverse([ExprAcc | Result]);
add_operators([], _, _, _, _, Result) -> Result;
add_operators([C | Rest], Target, ExprAcc, ValAcc, MulAcc, Result) ->
    Digit = C - $0,
    NewValAcc = ValAcc + MulAcc,
    NewMulAcc = MulAcc * 10 + Digit,
    NewExprAcc = lists:append(ExprAcc, [C]),
    add_operators(Rest, Target, NewExprAcc, NewValAcc, NewMulAcc, Result).

add_operators([C | Rest], Target, ExprAcc, ValAcc, MulAcc, Result) ->
    add_operator([C | Rest], Target, ExprAcc, ValAcc, MulAcc, Result, +);
    add_operator([C | Rest], Target, ExprAcc, ValAcc, MulAcc, Result, -);
    add_operator([C | Rest], Target, ExprAcc, ValAcc, MulAcc, Result, *).
