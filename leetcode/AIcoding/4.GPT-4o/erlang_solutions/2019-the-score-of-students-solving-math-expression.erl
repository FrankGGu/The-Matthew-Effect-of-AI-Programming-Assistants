-module(solution).
-export([score_of_students/2]).

score_of_students(Expr, Answers) ->
    CorrectScore = calculate_score(Expr),
    ValidScores = lists:map(fun(A) -> valid_score(Expr, A) end, Answers),
    lists:sum(ValidScores) + lists:sum([if A =:= CorrectScore -> 5; true -> 0 end || A <- Answers]).

calculate_score(Expr) ->
    case lists:foldl(fun(Ch, Acc) -> eval_expr(Acc, Ch) end, 0, string:to_list(Expr)) of
        Result -> Result
    end.

valid_score(Expr, Answer) ->
    CorrectScore = calculate_score(Expr),
    if Answer =:= CorrectScore -> 5; Answer < CorrectScore -> 2; true -> 0 end.

eval_expr(Acc, $+) -> Acc;
eval_expr(Acc, $-) -> Acc;
eval_expr(Acc, $*) -> Acc;
eval_expr(Acc, Ch) when Ch >= $0, Ch =< $9 -> Acc + (Ch - $0);
eval_expr(Acc, _) -> Acc.