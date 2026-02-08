-module(solution).
-export([evaluate/1]).

evaluate(Expression) ->
    {Result, _} = eval(Expression, #{}),
    Result.

eval(Expression, Env) ->
    case is_integer(Expression) of
        true -> {Expression, Env};
        false ->
            case is_atom(Expression) of
                true -> {maps:get(Expression, Env), Env};
                false ->
                    [H | T] = Expression,
                    case H of
                        'let' -> eval_let(T, Env);
                        'add' -> eval_add(T, Env);
                        'mult' -> eval_mult(T, Env);
                        _ -> eval(Expression, Env)
                    end
            end
    end.

eval_let([Var, Expr | Rest], Env) ->
    {Value, Env1} = eval(Expr, Env),
    NewEnv = maps:put(Var, Value, Env),
    case Rest of
        [] -> {Value, NewEnv};
        [Expr1] -> eval(Expr1, NewEnv)
    end.

eval_add([Expr1, Expr2], Env) ->
    {V1, Env1} = eval(Expr1, Env),
    {V2, Env2} = eval(Expr2, Env1),
    {V1 + V2, Env2}.

eval_mult([Expr1, Expr2], Env) ->
    {V1, Env1} = eval(Expr1, Env),
    {V2, Env2} = eval(Expr2, Env1),
    {V1 * V2, Env2}.