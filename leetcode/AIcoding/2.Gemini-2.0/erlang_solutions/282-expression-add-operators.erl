-module(expression_add_operators).
-export([add_operators/2]).

add_operators(Num, Target) ->
    Digits = string:to_integer_list(Num),
    add_operators_helper(Digits, Target, 0, 0, [], []).

add_operators_helper(Digits, Target, CurrentValue, PreviousOperand, Acc, Result) ->
    case Digits of
        [] ->
            if CurrentValue =:= Target then
                lists:reverse(Acc) ++ Result
            else
                Result
            end;
        _ ->
            lists:foldl(
                fun(Length, AccResult) ->
                    if AccResult =/= [] then
                        AccResult
                    else
                        SubDigits = lists:sublist(Digits, Length),
                        Value = list_to_integer(SubDigits),
                        if Length > 1 andalso lists:nth(1, SubDigits) =:= $0 then
                            AccResult
                        else
                            NewDigits = lists:nthtail(Length, Digits),
                            NewResult1 = add_operators_helper(NewDigits, Target, Value, Value, [Value], AccResult),
                            NewResult2 = add_operators_op_helper(NewDigits, Target, CurrentValue, PreviousOperand, Value, "+", [Value, $+], Acc),
                            NewResult3 = add_operators_op_helper(NewDigits, Target, CurrentValue, PreviousOperand, Value, "-", [Value, $-], Acc),
                            NewResult4 = add_operators_op_helper(NewDigits, Target, CurrentValue, PreviousOperand, Value, "*", [Value, $*], Acc),
                            NewResult1 ++ NewResult2 ++ NewResult3 ++ NewResult4
                        end
                    end
                end,
                [],
                lists:seq(1, length(Digits))
            ).

add_operators_op_helper(Digits, Target, CurrentValue, PreviousOperand, Value, Op, Acc, PreviousAcc) ->
    case Op of
        "+" ->
            add_operators_helper(Digits, Target, CurrentValue + Value, Value, Acc, PreviousAcc);
        "-" ->
            add_operators_helper(Digits, Target, CurrentValue - Value, -Value, Acc, PreviousAcc);
        "*" ->
            add_operators_helper(Digits, Target, CurrentValue - PreviousOperand + PreviousOperand * Value, PreviousOperand * Value, Acc, PreviousAcc)
    end.

list_to_integer(Digits) ->
    list_to_integer_helper(Digits, 0).

list_to_integer_helper([], Acc) ->
    Acc;
list_to_integer_helper([Digit | Rest], Acc) ->
    list_to_integer_helper(Rest, Acc * 10 + Digit - $0).