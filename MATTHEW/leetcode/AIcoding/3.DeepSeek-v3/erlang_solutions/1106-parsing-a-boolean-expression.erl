-module(solution).
-export([parse_bool_expr/1]).

parse_bool_expr(Expression) ->
    {Result, _} = parse(Expression),
    Result.

parse([$t | Rest]) -> {true, Rest};
parse([$f | Rest]) -> {false, Rest};
parse([$! | Rest]) ->
    {Expr, NewRest} = parse(Rest),
    {not Expr, tl(NewRest)};
parse([$& | Rest]) ->
    {Exprs, NewRest} = parse_list(Rest),
    {lists:all(fun(X) -> X end, Exprs), NewRest};
parse([$| | Rest]) ->
    {Exprs, NewRest} = parse_list(Rest),
    {lists:any(fun(X) -> X end, Exprs), NewRest}.

parse_list([$( | Rest]) ->
    parse_exprs(Rest, []).

parse_exprs([$) | Rest], Acc) -> {lists:reverse(Acc), Rest};
parse_exprs([$, | Rest], Acc) ->
    parse_exprs(Rest, Acc);
parse_exprs(Str, Acc) ->
    {Expr, NewRest} = parse(Str),
    parse_exprs(NewRest, [Expr | Acc]).