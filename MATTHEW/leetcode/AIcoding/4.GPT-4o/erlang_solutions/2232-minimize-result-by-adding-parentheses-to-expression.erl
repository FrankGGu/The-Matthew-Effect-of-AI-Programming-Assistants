-module(solution).
-export([minimize_result/1]).

minimize_result(Expression) ->
    Parts = string:split(Expression, "+", all),
    {Left, Right} = case Parts of
        [L, R] -> {L, R};
        _ -> {"" , ""}
    end,
    MinValue = lists:foldl(fun({L1, R1}, Acc) ->
        Value = evaluate(L1, R1),
        if
            Value < Acc -> Value;
            true -> Acc
        end
    end, evaluate(Left, Right), generate_positions(Left, Right)),
    format_result(Left, Right, MinValue).

evaluate(Left, Right) ->
    case {string:to_integer(Left), string:to_integer(Right)} of
        {L, R} -> L + R;
        _ -> 0
    end.

generate_positions(Left, Right) ->
    [{LStart, RStart} || LStart <- lists:seq(0, string:length(Left)), RStart <- lists:seq(0, string:length(Right))].

format_result(Left, Right, MinValue) ->
    Result = lists:foldl(fun({LStart, RStart}, Acc) ->
        case Acc of
            {Best, _} -> {Best, []}
        end
    end, {MinValue, ""}, generate_positions(Left, Right)),
    Result.