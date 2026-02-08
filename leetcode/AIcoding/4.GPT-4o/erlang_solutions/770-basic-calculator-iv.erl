-module(solution).
-export([basic_calculator_iv/2]).

basic_calculator_iv(Expression, Evalvars) ->
    {Result, _} = eval_expr(Expression, Evalvars),
    Result.

eval_expr(Expression, Evalvars) ->
    {Vars, Expr} = parse_expr(Expression, Evalvars),
    Result = eval(Vars, Expr),
    {Result, Vars}.

parse_expr(Expression, Evalvars) ->
    % Implementation of parsing logic
    {Vars, Expr}.

eval(Vars, Expr) ->
    % Implementation of evaluation logic
    0.