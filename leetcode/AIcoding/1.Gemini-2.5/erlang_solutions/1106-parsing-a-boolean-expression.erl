-module(solution).
-export([is_boolean_expression/1]).

is_boolean_expression(Expression) ->
    {Value, _Rest} = parse_expr(Expression),
    Value.

parse_expr([$t | Rest]) ->
    {true, Rest};
parse_expr([$f | Rest]) ->
    {false, Rest};
parse_expr([$! | Rest]) ->
    [$ ( | SubExprStr] = Rest,
    {SubValue, [$ ) | AfterParen]} = parse_expr(SubExprStr),
    {not SubValue, AfterParen};
parse_expr([$& | Rest]) ->
    [$ ( | SubExprStr] = Rest,
    {Values, [$ ) | AfterParen]} = parse_list_exprs(SubExprStr, []),
    {lists:all(fun(X) -> X == true end, Values), AfterParen};
parse_expr([$| | Rest]) ->
    [$ ( | SubExprStr] = Rest,
    {Values, [$ ) | AfterParen]} = parse_list_exprs(SubExprStr, []),
    {lists:any(fun(X) -> X == true end, Values), AfterParen}.

parse_list_exprs(String, Acc) ->
    {Value, RestAfterExpr} = parse_expr(String),
    case hd(RestAfterExpr) of
        $, ->
            parse_list_exprs(tl(RestAfterExpr), Acc ++ [Value]);
        $) ->
            {Acc ++ [Value], RestAfterExpr}
    end.