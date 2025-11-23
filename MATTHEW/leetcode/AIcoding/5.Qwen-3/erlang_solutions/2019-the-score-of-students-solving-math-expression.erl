-module(solution).
-export([score_after_operations/1]).

score_after_operations(Expression) ->
    Expr = string:to_lower(Expression),
    {ok, Tokens, _} = erl_scan:string(Expr ++ "."), 
    {ok, AST} = erl_parse:parse_exprs(Tokens),
    Result = eval(AST),
    case Result of
        {error, _} -> 0;
        _ -> count_correct_answers(Expr, Result)
    end.

eval([{op, _, '+', A, B} | _]) -> eval(A) + eval(B);
eval([{op, _, '-', A, B} | _]) -> eval(A) - eval(B);
eval([{op, _, '*', A, B} | _]) -> eval(A) * eval(B);
eval([{op, _, '/', A, B} | _]) -> eval(A) div eval(B);
eval([{integer, _, N} | _]) -> N;
eval([{var, _, _} | _]) -> 0;
eval(_) -> 0.

count_correct_answers(_, _) -> 0.