-module(spreadsheet).
-export([new/0, set_cell/3, get_cell/2, compute/1]).

new() ->
    #{}.

set_cell(CellId, Value, Sheet) ->
    maps:put(CellId, Value, Sheet).

get_cell(CellId, Sheet) ->
    maps:get(CellId, Sheet, 0).

compute(Sheet) ->
    compute(Sheet, maps:keys(Sheet), []).

compute(_, [], Result) ->
    lists:reverse(Result);
compute(Sheet, [CellId | Rest], Acc) ->
    Value = eval(CellId, Sheet),
    compute(Sheet, Rest, [{CellId, Value} | Acc]).

eval(CellId, Sheet) ->
    case maps:get(CellId, Sheet, undefined) of
        undefined -> 0;
        Value when is_integer(Value) -> Value;
        Value when is_binary(Value) ->
            parse_expression(Value, Sheet)
    end.

parse_expression(Expression, Sheet) ->
    Tokens = tokenize(Expression),
    eval_tokens(Tokens, Sheet).

tokenize(Str) ->
    re:split(Str, "([+\\-*/()])", [{return, list}, {capture, all, list}]).

eval_tokens([], _) -> 0;
eval_tokens([Token | Rest], Sheet) ->
    case Token of
        "+" -> eval_op("+", Rest, Sheet);
        "-" -> eval_op("-", Rest, Sheet);
        "*" -> eval_op("*", Rest, Sheet);
        "/" -> eval_op("/", Rest, Sheet);
        "(" -> eval_paren(Rest, Sheet);
        _ -> 
            if 
                is_number(Token) -> list_to_integer(Token);
                true -> eval_cell(Token, Sheet)
            end
    end.

eval_op(Op, Tokens, Sheet) ->
    A = eval_tokens(Tokens, Sheet),
    B = eval_tokens(tail(Tokens), Sheet),
    apply_op(Op, A, B).

eval_paren(Tokens, Sheet) ->
    {Expr, Rest} = read_expr(Tokens, []),
    Value = eval_tokens(Expr, Sheet),
    eval_tokens(Rest, Sheet).

read_expr([], _) -> {[], []};
read_expr([")" | Rest], Expr) -> {lists:reverse(Expr), Rest};
read_expr([Token | Rest], Expr) ->
    read_expr(Rest, [Token | Expr]).

eval_cell(CellId, Sheet) ->
    case maps:get(CellId, Sheet, undefined) of
        undefined -> 0;
        Value when is_integer(Value) -> Value;
        Value when is_binary(Value) ->
            parse_expression(Value, Sheet)
    end.

apply_op("+", A, B) -> A + B;
apply_op("-", A, B) -> A - B;
apply_op("*", A, B) -> A * B;
apply_op("/", A, B) -> A / B.