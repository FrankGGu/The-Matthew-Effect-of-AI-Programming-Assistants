-module(basic_calculator_iv).
-export([basic_calculator_iv/3]).

basic_calculator_iv(Expression, Evalvars, Evalints) ->
    Env = lists:zip(Evalvars, Evalints),
    {ok, Tokens, _} = erl_scan:string(Expression ++ "."),
    Result = evaluate(Tokens, Env),
    format_result(Result).

evaluate(Tokens, Env) ->
    {Expr, []} = parse(Tokens),
    evaluate_expr(Expr, Env).

parse(Tokens) ->
    parse(Tokens, []).

parse([], Acc) ->
    {lists:reverse(Acc), []};
parse([Token | Rest], Acc) ->
    case Token of
        {atom, plus} ->
            parse_expr(Rest, Acc, 1);
        {atom, minus} ->
            parse_expr(Rest, Acc, -1);
        {integer, Num} ->
            parse_expr(Rest, Acc, Num);
        {float, Num} ->
            parse_expr(Rest, Acc, Num);
        {atom, Var} ->
            parse_expr(Rest, Acc, Var);
        {punct, '('} ->
            {SubExpr, Rest2} = parse(Rest),
            parse_expr(Rest2, Acc, SubExpr);
        {punct, ')'} ->
            {lists:reverse(Acc), Rest};
        {punct, '*'} ->
            {Expr, Rest2} = parse(Rest),
            {lists:reverse(Acc), Rest2, Expr, '*'};
        {punct, '/'} ->
            {Expr, Rest2} = parse(Rest),
            {lists:reverse(Acc), Rest2, Expr, '/'};
        {punct, '+'} ->
           parse_expr(Rest, Acc, 1);
        {punct, '-'} ->
           parse_expr(Rest, Acc, -1);
        {punct, '.'} ->
            {lists:reverse(Acc), []};
        _ ->
            io:format("Error: Unexpected token ~p~n", [Token]),
            {lists:reverse(Acc), Rest}
    end.

parse_expr(Rest, Acc, Expr) ->
    case Rest of
        [{punct, '*'} | Rest2] ->
            {Expr2, Rest3} = parse(Rest2),
            parse_expr(Rest3, Acc, {'*', Expr, Expr2});
        [{punct, '/'} | Rest2] ->
            {Expr2, Rest3} = parse(Rest2),
            parse_expr(Rest3, Acc, {'/', Expr, Expr2});
        [{punct, '+'} | Rest2] ->
            {Expr2, Rest3} = parse(Rest2),
            parse_expr(Rest3, Acc, {'+', Expr, Expr2});
        [{punct, '-'} | Rest2] ->
            {Expr2, Rest3} = parse(Rest2),
            parse_expr(Rest3, Acc, {'-', Expr, Expr2});
        _ ->
            parse(Rest, [Expr | Acc])
    end.

evaluate_expr(Expr, Env) ->
    evaluate_expr(Expr, Env, []).

evaluate_expr(Expr, Env, Acc) ->
    case Expr of
        Num when is_integer(Num) ->
            [{[{[], Num}], 1}];
        Var when is_atom(Var) ->
            case lists:keyfind(Var, 1, Env) of
                {Var, Val} ->
                    [{[{[], Val}], 1}];
                false ->
                    [{[{[Var], 1}], 1}]
            end;
        {Op, Expr1, Expr2} ->
            Result1 = evaluate_expr(Expr1, Env),
            Result2 = evaluate_expr(Expr2, Env),
            combine(Result1, Result2, Op);
        _ ->
            io:format("Error: Unexpected expression ~p~n", [Expr]),
            []
    end.

combine(Result1, Result2, Op) ->
    NewResult = lists:flatten([
        [merge_terms(Term1, Term2, Op) || Term2 <- Result2] || Term1 <- Result1
    ]),
    simplify(NewResult).

merge_terms(Term1, Term2, Op) ->
    {Poly1, Coeff1} = Term1,
    {Poly2, Coeff2} = Term2,
    NewPoly = merge_polynomials(Poly1, Poly2),
    NewCoeff = calculate(Coeff1, Coeff2, Op),
    [{NewPoly, NewCoeff}].

merge_polynomials(Poly1, Poly2) ->
    NewPoly = lists:foldl(fun({Vars, Power}, Acc) ->
        case lists:keyfind(Vars, 1, Acc) of
            {Vars, OldPower} ->
                lists:keyreplace(Vars, 1, Acc, {Vars, OldPower + Power});
            false ->
                [{Vars, Power} | Acc]
        end
    end, Poly1, Poly2),
    lists:sort(fun({V1, _}, {V2, _}) -> V1 < V2 end, NewPoly).

calculate(Coeff1, Coeff2, '+') -> Coeff1 + Coeff2;
calculate(Coeff1, Coeff2, '-') -> Coeff1 - Coeff2;
calculate(Coeff1, Coeff2, '*') -> Coeff1 * Coeff2;
calculate(Coeff1, Coeff2, '/') -> Coeff1 div Coeff2.

simplify(Result) ->
    Groups = lists:group(fun({Poly1, _}, {Poly2, _}) -> Poly1 == Poly2 end, Result),
    lists:map(fun(Group) ->
        Coeff = lists:sum([Coeff || {_, Coeff} <- Group]),
        {hd(Group), Coeff}
    end, Groups).

format_result(Result) ->
    FilteredResult = lists:filter(fun({_, Coeff}) -> Coeff /= 0 end, Result),
    SortedResult = lists:keysort(fun({Vars, _}) -> -lists:sum([Power || {_, Power} <- Vars]) end, FilteredResult),
    [format_term(Term) || Term <- SortedResult].

format_term({Vars, Coeff}) ->
    VarsStr = string:join([atom_to_list(Var) ++ (if Power == 1 -> ""; true -> "**" ++ integer_to_list(Power) end) || {Var, Power} <- Vars], "*"),
    case VarsStr of
        "" ->
            integer_to_list(Coeff);
        _ ->
            case Coeff of
                1 ->
                    VarsStr;
                -1 ->
                    "-" ++ VarsStr;
                _ ->
                    integer_to_list(Coeff) ++ "*" ++ VarsStr
            end
    end.