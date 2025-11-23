-module(expression_min_cost).

-export([min_cost_to_change_final_value/1]).

min_cost_to_change_final_value(Expression) ->
    {Result, _} = parse_expression(Expression),
    Result.

parse_expression(Expression) ->
    parse_expression(Expression, []).

parse_expression([], Stack) ->
    case Stack of
        [Val] -> {Val, []};
        _ -> {0, []} %Should not happen
    end;
parse_expression([C | Rest], Stack) when C == '(' ->
    {Result, Rest2} = parse_expression(Rest, []),
    parse_expression(Rest2, [Result | Stack]);
parse_expression([C | Rest], Stack) when C == ')' ->
    case Stack of
        [Val | Stack2] -> {Val, Rest};
        _ -> {0, Rest} %Should not happen
    end;
parse_expression([C | Rest], Stack) when C == '&' ->
    {Result, Rest2} = parse_expression(Rest, []),
    case Stack of
        [Val | Stack3] ->
            AndResult = min(Val, Result),
            parse_expression(Rest2, [AndResult | Stack3]);
        _ -> {0, Rest} %Should not happen
    end;
parse_expression([C | Rest], Stack) when C == '|' ->
    {Result, Rest2} = parse_expression(Rest, []),
    case Stack of
        [Val | Stack3] ->
            OrResult = max(Val, Result),
            parse_expression(Rest2, [OrResult | Stack3]);
        _ -> {0, Rest} %Should not happen
    end;
parse_expression([C | Rest], Stack) when C == '0' ->
    parse_expression(Rest, [1 | Stack]);
parse_expression([C | Rest], Stack) when C == '1' ->
    parse_expression(Rest, [0 | Stack]);
parse_expression([C | Rest], Stack) when C == ' ' ->
    parse_expression(Rest, Stack).