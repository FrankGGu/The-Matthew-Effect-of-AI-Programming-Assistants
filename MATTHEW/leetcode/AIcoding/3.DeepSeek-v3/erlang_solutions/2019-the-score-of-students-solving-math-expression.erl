-module(solution).
-export([score_of_students/2]).

score_of_students(S, Answers) ->
    {Correct, _} = eval(S),
    Memo = maps:new(),
    Possible = possible_evals(S, Memo),
    lists:sum([score(Ans, Correct, Possible) || Ans <- Answers]).

eval(S) ->
    {Res, []} = eval_expr(S),
    {Res, Res}.

eval_expr([H | T]) when H >= $0, H =< $9 ->
    eval_term(T, H - $0);
eval_expr(_) -> {0, []}.

eval_term([$* | T], Acc) ->
    {Num, Rest} = eval_num(T),
    eval_term(Rest, Acc * Num);
eval_term([$+ | T], Acc) ->
    {Num, Rest} = eval_expr(T),
    {Acc + Num, Rest};
eval_term([$- | T], Acc) ->
    {Num, Rest} = eval_expr(T),
    {Acc - Num, Rest};
eval_term(Rest, Acc) -> {Acc, Rest}.

eval_num([H | T]) when H >= $0, H =< $9 ->
    eval_num(T, H - $0);
eval_num(_) -> {0, []}.

eval_num([H | T], Acc) when H >= $0, H =< $9 ->
    eval_num(T, Acc * 10 + (H - $0));
eval_num(Rest, Acc) -> {Acc, Rest}.

possible_evals(S, Memo) ->
    case maps:get(S, Memo, none) of
        none ->
            case length(S) of
                1 -> 
                    Res = sets:from_list([lists:nth(1, S) - $0]),
                    {Res, maps:put(S, Res, Memo)};
                _ ->
                    {Res, NewMemo} = split_and_combine(S, Memo),
                    {Res, maps:put(S, Res, NewMemo)}
            end;
        Cached -> {Cached, Memo}
    end.

split_and_combine(S, Memo) ->
    split_and_combine(S, 1, length(S), sets:new(), Memo).

split_and_combine(S, Pos, Len, Acc, Memo) when Pos < Len ->
    case lists:nth(Pos, S) of
        Op when Op == $+; Op == $-; Op == $* ->
            {Left, Memo1} = possible_evals(string:sub_string(S, 1, Pos - 1), Memo),
            {Right, Memo2} = possible_evals(string:sub_string(S, Pos + 1), Memo1),
            NewAcc = combine(Left, Right, Op, Acc),
            split_and_combine(S, Pos + 1, Len, NewAcc, Memo2);
        _ ->
            split_and_combine(S, Pos + 1, Len, Acc, Memo)
    end;
split_and_combine(_, _, _, Acc, Memo) -> {Acc, Memo}.

combine(Left, Right, Op, Acc) ->
    sets:union(Acc, sets:from_list([compute(L, R, Op) || L <- sets:to_list(Left), R <- sets:to_list(Right)])).

compute(L, R, $+) -> L + R;
compute(L, R, $-) -> L - R;
compute(L, R, $*) -> L * R.

score(Ans, Correct, Possible) ->
    case Ans of
        Correct -> 5;
        _ -> case sets:is_element(Ans, Possible) of
                true -> 2;
                false -> 0
             end
    end.