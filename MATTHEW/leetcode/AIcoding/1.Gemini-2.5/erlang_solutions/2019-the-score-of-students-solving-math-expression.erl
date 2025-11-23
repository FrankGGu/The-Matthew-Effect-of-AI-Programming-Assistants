-module(solution).
-export([score_of_students/2]).

parse_expression(S) ->
    parse_expression(S, [], []).

parse_expression([], AccDigits, AccOps) ->
    {lists:reverse(AccDigits), lists:reverse(AccOps)};
parse_expression([Char | Rest], AccDigits, AccOps) when Char >= $0, Char =< $9 ->
    parse_expression(Rest, [Char - $0 | AccDigits], AccOps);
parse_expression([OpChar | Rest], AccDigits, AccOps) ->
    parse_expression(Rest, AccDigits, [OpChar | AccOps]).

apply_op(Val1, Op, Val2) ->
    case Op of
        $'+' -> Val1 + Val2;
        $'*' -> Val1 * Val2
    end.

eval_true_val(Digits, Ops) ->
    {DigitsAfterMult, _OpsAfterMult} = eval_mult_pass(Digits, Ops, [], []),
    lists:foldl(fun(X, Sum) -> Sum + X end, 0, DigitsAfterMult).

eval_mult_pass([D], [], AccDigits, AccOps) ->
    {lists:reverse([D | AccDigits]), lists:reverse(AccOps)};
eval_mult_pass([D1, D2 | RestD], [Op | RestO], AccDigits, AccOps) ->
    case Op of
        $'*' -> eval_mult_pass([D1*D2 | RestD], RestO, AccDigits, AccOps);
        $'+' -> eval_mult_pass([D2 | RestD], RestO, [D1 | AccDigits], [Op | AccOps])
    end.

solve_dp(I, J, Digits, Ops, Memo) ->
    case maps:find({I, J}, Memo) of
        {ok, Values} -> {Values, Memo};
        error ->
            NewValues = 
                if I == J ->
                    gb_sets:from_list([lists:nth(I + 1, Digits)]);
                else
                    lists:foldl(fun(K, AccValues) ->
                        {LeftValues, Memo1} = solve_dp(I, K, Digits, Ops, Memo),
                        {RightValues, Memo2} = solve_dp(K + 1, J, Digits, Ops, Memo1),
                        Op = lists:nth(K + 1, Ops),

                        ValuesFromSplit = gb_sets:new(),
                        CombinedValues = gb_sets:fold(fun(Val1, AccCombined) ->
                            gb_sets:fold(fun(Val2, AccCombined2) ->
                                Res = apply_op(Val1, Op, Val2),
                                if Res =< 1000 -> gb_sets:add(Res, AccCombined2);
                                   true -> AccCombined2
                                end
                            end, AccCombined, RightValues)
                        end, ValuesFromSplit, LeftValues),

                        gb_sets:union(AccValues, CombinedValues)
                    end, gb_sets:new(), lists:seq(I, J - 1))
                end,
            NewMemo = maps:put({I, J}, NewValues, Memo),
            {NewValues, NewMemo}
    end.

score_of_students(S, StudentAnswers) ->
    {Digits, Ops} = parse_expression(S),
    N = length(Digits),

    TrueValue = eval_true_val(Digits, Ops),

    {AllPossibleValues, _FinalMemo} = solve_dp(0, N - 1, Digits, Ops, maps:new()),

    lists:foldl(fun(Ans, Score) ->
        if Ans == TrueValue ->
            Score + 5;
        gb_sets:is_element(Ans, AllPossibleValues) ->
            Score + 2;
        true ->
            Score
        end
    end, 0, StudentAnswers).