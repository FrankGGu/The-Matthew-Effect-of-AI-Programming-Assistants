-module(basic_calculator_iv).
-export([basic_calculator_iv/2]).

basic_calculator_iv(Expression, Evalvars) ->
    Tokens = tokenize(Expression),
    {Vars, _} = lists:foldl(fun([K, V], {Acc, I}) -> {maps:put(K, I, Acc), I + 1} end, {#{}, 0}, Evalvars),
    {Poly, _} = parse_expression(Tokens, Vars),
    Sorted = lists:sort(fun(A, B) -> compare(A, B) end, maps:to_list(Poly)),
    Result = lists:filtermap(fun({K, V}) -> if V =/= 0 -> {true, format_term(K, V, Vars)}; true -> false end end, Sorted),
    Result.

tokenize(Expression) ->
    {ok, Tokens, _} = erl_scan:string(Expression ++ "."),
    lists:filtermap(fun
        ({'+', _}) -> {true, '+'};
        ({'-', _}) -> {true, '-'};
        ({'*', _}) -> {true, '*'};
        ({'(', _}) -> {true, '('};
        ({')', _}) -> {true, ')'};
        ({var, _, Var}) -> {true, {var, Var}};
        ({integer, _, Num}) -> {true, {num, Num}};
        (_) -> false
    end, Tokens).

parse_expression(Tokens, Vars) ->
    parse_add_sub(Tokens, Vars).

parse_add_sub(Tokens, Vars) ->
    {Left, Rest} = parse_mul_div(Tokens, Vars),
    parse_add_sub_rest(Rest, Vars, Left).

parse_add_sub_rest([Op | Rest], Vars, Left) when Op =:= '+'; Op =:= '-' ->
    {Right, NewRest} = parse_mul_div(Rest, Vars),
    NewLeft = case Op of
        '+' -> add(Left, Right);
        '-' -> subtract(Left, Right)
    end,
    parse_add_sub_rest(NewRest, Vars, NewLeft);
parse_add_sub_rest(Rest, _Vars, Left) ->
    {Left, Rest}.

parse_mul_div(Tokens, Vars) ->
    {Left, Rest} = parse_primary(Tokens, Vars),
    parse_mul_div_rest(Rest, Vars, Left).

parse_mul_div_rest([Op | Rest], Vars, Left) when Op =:= '*' ->
    {Right, NewRest} = parse_primary(Rest, Vars),
    NewLeft = multiply(Left, Right),
    parse_mul_div_rest(NewRest, Vars, NewLeft);
parse_mul_div_rest(Rest, _Vars, Left) ->
    {Left, Rest}.

parse_primary([{num, Num} | Rest], _Vars) ->
    {#{[] => Num}, Rest};
parse_primary([{var, Var} | Rest], Vars) ->
    case maps:get(Var, Vars, not_found) of
        not_found -> {#{ [Var] => 1 }, Rest};
        _ -> {#{ [] => maps:get(Var, Vars) }, Rest}
    end;
parse_primary(['(' | Rest], Vars) ->
    {Expr, [')' | NewRest]} = parse_expression(Rest, Vars),
    {Expr, NewRest};
parse_primary(['-' | Rest], Vars) ->
    {Expr, NewRest} = parse_primary(Rest, Vars),
    {negate(Expr), NewRest}.

add(Poly1, Poly2) ->
    maps:fold(fun(K, V, Acc) -> maps:update_with(K, fun(Old) -> Old + V end, V, Acc) end, Poly1, Poly2).

subtract(Poly1, Poly2) ->
    maps:fold(fun(K, V, Acc) -> maps:update_with(K, fun(Old) -> Old - V end, -V, Acc) end, Poly1, Poly2).

multiply(Poly1, Poly2) ->
    maps:fold(fun(K1, V1, Acc1) ->
        maps:fold(fun(K2, V2, Acc2) ->
            NewKey = lists:sort(K1 ++ K2),
            maps:update_with(NewKey, fun(Old) -> Old + V1 * V2 end, V1 * V2, Acc2)
        end, Acc1, Poly2)
    end, #{}, Poly1).

negate(Poly) ->
    maps:map(fun(_K, V) -> -V end, Poly).

compare({Key1, _}, {Key2, _}) ->
    Len1 = length(Key1),
    Len2 = length(Key2),
    if
        Len1 > Len2 -> true;
        Len1 < Len2 -> false;
        true -> Key1 =< Key2
    end.

format_term([], Coeff, _Vars) -> integer_to_list(Coeff);
format_term(Vars, Coeff, VarsMap) ->
    VarParts = lists:map(fun(V) -> atom_to_list(V) end, Vars),
    VarStr = string:join(VarParts, "*"),
    if
        Coeff =:= 1 -> VarStr;
        Coeff =:= -1 -> "-" ++ VarStr;
        true -> integer_to_list(Coeff) ++ "*" ++ VarStr
    end.