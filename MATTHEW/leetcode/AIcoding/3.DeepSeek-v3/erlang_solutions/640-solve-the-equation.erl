-spec solve_equation(Equation :: unicode:unicode_binary()) -> unicode:unicode_binary().
solve_equation(Equation) ->
    [Left, Right] = binary:split(Equation, <<"=">>),
    {A1, B1} = parse_expression(Left),
    {A2, B2} = parse_expression(Right),
    A = A1 - A2,
    B = B2 - B1,
    if
        A == 0 andalso B == 0 -> <<"Infinite solutions">>;
        A == 0 -> <<"No solution">>;
        true ->
            Ans = B div A,
            <<"x=", (integer_to_binary(Ans))/binary>>
    end.

parse_expression(Expr) ->
    parse_expression(Expr, 0, 0, <<>>, 1).

parse_expression(<<>>, A, B, <<>>, _) -> {A, B};
parse_expression(<<>>, A, B, Acc, Sign) ->
    case binary:last(Acc) of $x ->
        {A + Sign * parse_number(binary:part(Acc, 0, byte_size(Acc) - 1)), B};
    true ->
        {A, B + Sign * parse_number(Acc)}
    end;
parse_expression(<<$+, Rest/binary>>, A, B, <<>>, _) ->
    parse_expression(Rest, A, B, <<>>, 1);
parse_expression(<<$+, Rest/binary>>, A, B, Acc, Sign) ->
    case binary:last(Acc) of $x ->
        parse_expression(Rest, A + Sign * parse_number(binary:part(Acc, 0, byte_size(Acc) - 1)), B, <<>>, 1);
    true ->
        parse_expression(Rest, A, B + Sign * parse_number(Acc), <<>>, 1)
    end;
parse_expression(<<$-, Rest/binary>>, A, B, <<>>, _) ->
    parse_expression(Rest, A, B, <<>>, -1);
parse_expression(<<$-, Rest/binary>>, A, B, Acc, Sign) ->
    case binary:last(Acc) of $x ->
        parse_expression(Rest, A + Sign * parse_number(binary:part(Acc, 0, byte_size(Acc) - 1)), B, <<>>, -1);
    true ->
        parse_expression(Rest, A, B + Sign * parse_number(Acc), <<>>, -1)
    end;
parse_expression(<<C, Rest/binary>>, A, B, Acc, Sign) ->
    parse_expression(Rest, A, B, <<Acc/binary, C>>, Sign).

parse_number(<<>>) -> 1;
parse_number(<<"+">>) -> 1;
parse_number(<<"-">>) -> -1;
parse_number(Bin) -> binary_to_integer(Bin).