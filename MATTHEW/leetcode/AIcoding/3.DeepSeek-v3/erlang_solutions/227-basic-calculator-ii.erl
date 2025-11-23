-module(solution).
-export([calculate/1]).

calculate(S) ->
    Tokens = tokenize(S),
    evaluate(Tokens, [], []).

tokenize(S) ->
    tokenize(S, []).

tokenize([], Acc) ->
    lists:reverse(Acc);
tokenize([C | Rest], Acc) when C =:= $  ->
    tokenize(Rest, Acc);
tokenize([C | Rest], Acc) when C >= $0, C =< $9 ->
    {Num, NewRest} = collect_number([C | Rest]),
    tokenize(NewRest, [{num, Num} | Acc]);
tokenize([C | Rest], Acc) ->
    tokenize(Rest, [{op, C} | Acc]).

collect_number(S) ->
    collect_number(S, 0).

collect_number([], Num) ->
    {Num, []};
collect_number([C | Rest], Num) when C >= $0, C =< $9 ->
    collect_number(Rest, Num * 10 + (C - $0));
collect_number(Rest, Num) ->
    {Num, Rest}.

evaluate([], NumStack, []) ->
    hd(NumStack);
evaluate([], NumStack, OpStack) ->
    evaluate([], do_op(NumStack, OpStack), tl(OpStack));
evaluate([{num, Num} | Rest], NumStack, OpStack) ->
    evaluate(Rest, [Num | NumStack], OpStack);
evaluate([{op, Op} | Rest], NumStack, OpStack) ->
    case OpStack of
        [] ->
            evaluate(Rest, NumStack, [Op]);
        [PrevOp | _] ->
            case precedence(Op) =< precedence(PrevOp) of
                true ->
                    evaluate([{op, Op} | Rest], do_op(NumStack, OpStack), tl(OpStack));
                false ->
                    evaluate(Rest, NumStack, [Op | OpStack])
            end
    end.

do_op([B, A | NumRest], [Op | OpRest]) ->
    Result = case Op of
        $+ -> A + B;
        $- -> A - B;
        $* -> A * B;
        $/ -> A div B
    end,
    [Result | NumRest].

precedence(Op) ->
    case Op of
        $+ -> 1;
        $- -> 1;
        $* -> 2;
        $/ -> 2
    end.