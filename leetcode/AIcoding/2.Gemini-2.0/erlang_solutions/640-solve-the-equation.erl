-module(solve_equation).
-export([solve_equation/1]).

solve_equation(Equation) ->
    {LHS, RHS} = split_equation(Equation),
    {XCoeffL, ConstL} = parse_side(LHS),
    {XCoeffR, ConstR} = parse_side(RHS),
    XCoeff = XCoeffL - XCoeffR,
    Const = ConstR - ConstL,
    if XCoeff == 0 ->
        if Const == 0 ->
            "Infinite solutions";
        true ->
            "No solution"
        end;
    true ->
        io_lib:format("x=~w", [Const div XCoeff])
    end.

split_equation(Equation) ->
    case string:split(Equation, "=", all) of
        [L, R] ->
            {L, R};
        _ ->
            exit("Invalid equation format")
    end.

parse_side(Side) ->
    Tokens = tokenize(Side),
    parse_tokens(Tokens, 0, 0).

tokenize(Side) ->
    string:tokens(Side, "+-").

parse_tokens([], XCoeff, Const) ->
    {XCoeff, Const};
parse_tokens([Token | Rest], XCoeff, Const) ->
    case string:to_integer(Token) of
        {Value, ""} ->
            parse_tokens(Rest, XCoeff, Const + Value);
        error ->
            case string:suffix(Token, "x") of
                true ->
                    ValueStr = string:sub_string(Token, 1, string:len(Token) - 1),
                    case ValueStr of
                        "" ->
                            parse_tokens(Rest, XCoeff + 1, Const);
                        "+" ->
                            parse_tokens(Rest, XCoeff + 1, Const);
                        "-" ->
                            parse_tokens(Rest, XCoeff - 1, Const);
                        _ ->
                            case string:to_integer(ValueStr) of
                                {Value, ""} ->
                                    parse_tokens(Rest, XCoeff + Value, Const);
                                error ->
                                    exit("Invalid equation format")
                            end
                    end;
                false ->
                    Sign = case string:chr(Token, 1) of
                        1 -> 1;
                        43 -> 1;
                        45 -> -1;
                        _ -> exit("Invalid equation format")
                    end,

                    {Value, _} = string:to_integer(Token),
                    parse_tokens(Rest, XCoeff, Const + Value * Sign)
            end
    end.