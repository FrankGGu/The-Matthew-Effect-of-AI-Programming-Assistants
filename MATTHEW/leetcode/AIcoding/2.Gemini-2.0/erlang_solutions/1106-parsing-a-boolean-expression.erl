-module(boolean_expression).
-export([parse_bool_expr/1]).

parse_bool_expr(Expression) ->
    {Value, _} = parse(Expression, 1),
    Value.

parse(Expression, Index) ->
    case string:at(Expression, Index) of
        't' -> {true, Index + 1};
        'f' -> {false, Index + 1};
        '!' ->
            {NewIndex, NextIndex} = skip_char(Expression, Index + 1, '('),
            {Value, NextIndex2} = parse(Expression, NextIndex),
            {not Value, skip_char(Expression, NextIndex2, ')')};
        '&' ->
            {Value, NextIndex} = parse_list(Expression, Index + 1, '('),
            {lists:all(fun(X) -> X end, Value), NextIndex};
        '|' ->
            {Value, NextIndex} = parse_list(Expression, Index + 1, '('),
            {lists:any(fun(X) -> X end, Value), NextIndex}
    end.

parse_list(Expression, Index, StartChar) ->
    {NewIndex, NextIndex} = skip_char(Expression, Index, StartChar),
    {Value, NextIndex2} = parse_list_helper(Expression, NextIndex, []),
    {lists:reverse(Value), NextIndex2}.

parse_list_helper(Expression, Index, Acc) ->
    {Value, NextIndex} = parse(Expression, Index),
    case string:at(Expression, NextIndex) of
        ')' -> {lists:append([Value], Acc), skip_char(Expression, NextIndex, ')')};
        ',' -> parse_list_helper(Expression, skip_char(Expression, NextIndex, ','), lists:append([Value], Acc))
    end.

skip_char(Expression, Index, Char) ->
    case string:at(Expression, Index) of
        Char -> {Char, Index + 1};
        _ -> {error, Index}
    end.