-module(score_of_students).
-export([scoreOfStudents/3]).

scoreOfStudents(S, A, E) ->
    Valid = valid_results(E),
    Correct = eval(E),
    score(S, A, Correct, Valid).

score(S, A, Correct, Valid) ->
    lists:foldl(fun(Ans, Acc) ->
        if Ans == Correct then
            Acc + 5
        else if lists:member(Ans, Valid) then
            Acc + 2
        else
            Acc
        end
    end, 0, A).

valid_results(Expr) ->
    {ok, Tokens, _} = erl_scan:string(Expr ++ "."),
    {ok, Tree} = erl_parse:parse(Tokens),
    memoize_valid_results(Tree).

memoize_valid_results(Tree) ->
    memoize_valid_results(Tree, #{}, []).

memoize_valid_results({op, _, _, _} = Node, Memo, Acc) ->
    case maps:is_key(Node, Memo) of
        true ->
            {Memo, Acc};
        false ->
            {Result, NewMemo, NewAcc} = calculate_valid_results(Node, Memo, Acc),
            {NewMemo, NewAcc}
    end.

calculate_valid_results({op, _, Op, {cons, _, Left, {cons, _, Right, nil}}}, Memo, Acc) ->
    {LeftResult, LeftMemo, LeftAcc} = memoize_valid_results(Left, Memo, Acc),
    {RightResult, RightMemo, RightAcc} = memoize_valid_results(Right, LeftMemo, LeftAcc),
    Results = for
        L <- LeftResult,
        R <- RightResult,
        case Op of
            '+' -> L + R <= 100;
            '*' -> L * R <= 100;
            _ -> false
        end,
        let Result = case Op of
            '+' -> L + R;
            '*' -> L * R
        end
    do
        Result
    end,
    UniqueResults = lists:usort(Results),
    NewMemo = maps:put({op, _, Op, {cons, _, Left, {cons, _, Right, nil}}}, UniqueResults, RightMemo),
    {UniqueResults, NewMemo, RightAcc ++ UniqueResults};
calculate_valid_results({integer, _, Int}, Memo, Acc) ->
    NewMemo = maps:put({integer, _, Int}, [Int], Memo),
    {[Int], NewMemo, Acc ++ [Int]}.

eval(Expr) ->
    {value, V, _} = erl_eval:expr(list_to_atom(Expr), []),
    V.