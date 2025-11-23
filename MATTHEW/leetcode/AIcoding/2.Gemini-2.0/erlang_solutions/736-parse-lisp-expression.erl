-module(parse_lisp).
-export([evaluate/1]).

evaluate(Expression) ->
    evaluate_expression(Expression, []).

evaluate_expression(Expression, Env) ->
    case Expression of
        "+" -> fun(A, B) -> A + B end;
        "*" -> fun(A, B) -> A * B end;
        X when is_atom(X) ->
            case proplists:get_value(X, Env) of
                undefined -> erlang:list_to_integer(erlang:atom_to_list(X));
                Value -> Value
            end;
        _ ->
            case Expression of
                {list, [A, B]} ->
                    evaluate_expression(A, Env)(evaluate_expression(B, Env), evaluate_expression(A, Env));
                {list, ["let", {list, Bindings}, Expr]} ->
                    NewEnv = lists:foldl(
                        fun({list, [Var, Val]}, AccEnv) ->
                            Value = evaluate_expression(Val, AccEnv),
                            [{Var, Value} | AccEnv]
                        end,
                        Env,
                        Bindings
                    ),
                    evaluate_expression(Expr, NewEnv);
                {list, ["add", X, Y]} ->
                    evaluate_expression(X, Env) + evaluate_expression(Y, Env);
                {list, ["mult", X, Y]} ->
                    evaluate_expression(X, Env) * evaluate_expression(Y, Env);
                {list, ["let", {list, []}, Expr]} ->
                    evaluate_expression(Expr, Env);
                {list, ["let", {list, [Binding]}, Expr]} ->
                    {list, [Var, Val]} = Binding,
                    Value = evaluate_expression(Val, Env),
                    NewEnv = [{Var, Value} | Env],
                    evaluate_expression(Expr, NewEnv);
                 {list, [Op | Args]} ->
                    case evaluate_expression(Op, Env) of
                        Fun when is_function(Fun) ->
                            Values = [evaluate_expression(Arg, Env) || Arg <- Args],
                            lists:foldl(Fun, lists:nth(1, Values), lists:nthtail(1, Values));
                        _ ->
                            erlang:error({invalid_operator, Op})
                    end;
                N when is_integer(N) -> N;
                A when is_atom(A) ->
                    case proplists:get_value(A, Env) of
                        undefined -> erlang:list_to_integer(erlang:atom_to_list(A));
                        Value -> Value
                    end;
                S when is_list(S) ->
                    try
                        erlang:list_to_integer(S)
                    catch
                        _:_ ->
                            case proplists:get_value(list_to_atom(S), Env) of
                                undefined -> erlang:list_to_integer(S);
                                Value -> Value
                            end
                    end
            end
    end.