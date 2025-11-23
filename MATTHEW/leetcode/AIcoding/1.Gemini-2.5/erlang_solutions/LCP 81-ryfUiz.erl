-module(solution).
-export([solve/1]).

to_nand_string({var, Var}) ->
    atom_to_list(Var);

to_nand_string({not, Expr}) ->
    ExprNand = to_nand_string(Expr),
    "(" ++ ExprNand ++ " NAND " ++ ExprNand ++ ")";

to_nand_string({and, Left, Right}) ->
    LeftStr = to_nand_string(Left),
    RightStr = to_nand_string(Right),
    CombinedNand = "(" ++ LeftStr ++ " NAND " ++ RightStr ++ ")",
    "(" ++ CombinedNand ++ " NAND " ++ CombinedNand ++ ")";

to_nand_string({or, Left, Right}) ->
    LeftNotNand = to_nand_string({not, Left}),
    RightNotNand = to_nand_string({not, Right}),
    "(" ++ LeftNotNand ++ " NAND " ++ RightNotNand ++ ").

tokenize(Str) ->
    tokenize(Str, []).

tokenize([], Acc) ->
    lists:reverse(Acc);
tokenize([C|Rest], Acc) when C >= $a, C =< $z ->
    tokenize(Rest, [{var, list_to_atom([C])} | Acc]);
tokenize([$!|Rest], Acc) ->
    tokenize(Rest, [{op, not} | Acc]);
tokenize([$&|Rest], Acc) ->
    tokenize(Rest, [{op, and} | Acc]);
tokenize([$||Rest], Acc) ->
    tokenize(Rest, [{op, or} | Acc]);
tokenize([$(|Rest], Acc) ->
    tokenize(Rest, [{op, lparen} | Acc]);
tokenize([$)|Rest], Acc) ->
    tokenize(Rest, [{op, rparen} | Acc]);
tokenize([$\s|Rest], Acc) ->
    tokenize(Rest, Acc);
tokenize([_C|Rest], Acc) ->
    error({unknown_character, _C}).

-record(parser_state, {tokens, index = 0}).

current_token(#parser_state{tokens = Tokens, index = Idx}) ->
    case Idx < length(Tokens) of
        true -> {ok, lists:nth(Idx + 1, Tokens)};
        false -> eof
    end.

advance(#parser_state{index = Idx} = State) ->
    State#parser_state{index = Idx + 1}.

parse_expr(State) ->
    {Expr, State1} = parse_term(State),
    parse_expr_rest(Expr, State1).

parse_expr_rest(Left, State) ->
    case current_token(State) of
        {ok, {op, or}} ->
            State1 = advance(State),
            {Right, State2} = parse_term(State1),
            parse_expr_rest({or, Left, Right}, State2);
        _ ->
            {Left, State}
    end.

parse_term(State) ->
    {Term, State1} = parse_factor(State),
    parse_term_rest(Term, State1).

parse_term_rest(Left, State) ->
    case current_token(State) of
        {ok, {op, and}} ->
            State1 = advance(State),
            {Right, State2} = parse_factor(State1),
            parse_term_rest({and, Left, Right}, State2);
        _ ->
            {Left, State}
    end.

parse_factor(State) ->
    case current_token(State) of
        {ok, {op, not}} ->
            State1 = advance(State),
            {Factor, State2} = parse_factor(State1),
            {{not, Factor}, State2};
        {ok, {op, lparen}} ->
            State1 = advance(State),
            {Expr, State2} = parse_expr(State1),
            case current_token(State2) of
                {ok, {op, rparen}} ->
                    {Expr, advance(State2)};
                _ ->
                    error("Parser error: Expected ')'")
            end;
        {ok, {var, Var}} ->
            {{var, Var}, advance(State)};
        _ ->
            error("Parser error: Unexpected token or end of expression")
    end.

solve(ExprString) ->
    Tokens = tokenize(ExprString),
    InitialState = #parser_state{tokens = Tokens},
    {AST, FinalState} = parse_expr(InitialState),
    case current_token(FinalState) of
        eof ->
            to_nand_string(AST);
        _ ->
            error("Parser error: Unparsed tokens remaining")
    end.