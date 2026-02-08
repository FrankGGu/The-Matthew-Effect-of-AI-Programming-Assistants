-module(solution).
-export([basic_calculator_iv/2]).

tokenize(S) -> tokenize(S, []).

tokenize([], Acc) -> lists:reverse(Acc);
tokenize([C|Rest], Acc) when C =:= $\s -> tokenize(Rest, Acc); % Skip whitespace
tokenize([C|Rest], Acc) when C >= $0, C =< $9 ->
    {NumStr, Rem} = span_digits([C|Rest]),
    Num = list_to_integer(NumStr),
    tokenize(Rem, [{int, Num}|Acc]);
tokenize([C|Rest], Acc) when C >= $a, C =< $z ->
    {VarStr, Rem} = span_letters([C|Rest]),
    tokenize(Rem, [{var, VarStr}|Acc]);
tokenize([$+|Rest], Acc) -> tokenize(Rest, [{op, '+'}|Acc]);
tokenize([$-|Rest], Acc) -> tokenize(Rest, [{op, '-'}|Acc]);
tokenize([$*|Rest], Acc) -> tokenize(Rest, [{op, '*'}|Acc]);
tokenize([$(|Rest], Acc) -> tokenize(Rest, [{paren, '('}|Acc]);
tokenize([$)|Rest], Acc) -> tokenize(Rest, [{paren, ')'}|Acc]);
tokenize([C|_], _) -> error({lexer_error, C}).

span_digits(S) -> span_digits(S, []).
span_digits([], Acc) -> {lists:reverse(Acc), []};
span_digits([C|Rest], Acc) when C >= $0, C =< $9 -> span_digits(Rest, [C|Acc]);
span_digits(S, Acc) -> {lists:reverse(Acc), S}.

span_letters(S) -> span_letters(S, []).
span_letters([], Acc) -> {lists:reverse(Acc), []};
span_letters([C|Rest], Acc) when C >= $a, C =< $z -> span_letters(Rest, [C|Acc]);
span_letters(S, Acc) -> {lists:reverse(Acc), S}.

poly_new(Term, Coeff) ->
    case Coeff of
        0 -> #{};
        _ -> #{list_to_tuple(lists:sort(Term)) => Coeff}
    end.

poly_add(P1, P2) ->
    maps:fold(fun(Term, Coeff, Acc) -> poly_add_term(Term, Coeff, Acc) end, P1, P2).

poly_sub(P1, P2) ->
    maps:fold(fun(Term, Coeff, Acc) -> poly_add_term(Term, -Coeff, Acc) end, P1, P2).

poly_add_term(Term, Coeff, Poly) ->
    case Coeff of
        0 -> Poly;
        _ ->
            maps:update_with(Term,
                fun(OldCoeff) ->
                    NewCoeff = OldCoeff + Coeff,
                    case NewCoeff of
                        0 -> maps:remove(Term, Poly);
                        _ -> maps:put(Term, NewCoeff, Poly)
                    end
                end,
                Coeff,
                Poly)
    end.

poly_mul(P1, P2) ->
    maps:fold(
        fun(T1, C1, Acc1) ->
            maps:fold(
                fun(T2, C2, Acc2) ->
                    NewCoeff = C1 * C2,
                    NewTermList = tuple_to_list(T1) ++ tuple_to_list(T2),
                    NewTerm = list_to_tuple(lists:sort(NewTermList)),
                    poly_add_term(NewTerm, NewCoeff, Acc2)
                end,
                Acc1,
                P2
            )
        end,
        #{},
        P1
    ).

poly_eval(Poly, EvalMap) ->
    lists:foldl(
        fun({Var, Val}, CurrentPoly) ->
            NewPoly = #{},
            maps:fold(
                fun(Term, Coeff, Acc) ->
                    TermList = tuple_to_list(Term),
                    case lists:member(Var, TermList) of
                        true ->
                            NewTermList = lists:delete(Var, TermList),
                            NewTerm = list_to_tuple(lists:sort(NewTermList)),
                            NewCoeff = Coeff * Val,
                            poly_add_term(NewTerm, NewCoeff, Acc);
                        false ->
                            poly_add_term(Term, Coeff, Acc)
                    end
                end,
                NewPoly,
                CurrentPoly
            )
        end,
        Poly,
        maps:to_list(EvalMap)
    ).

parse(Tokens) ->
    {Poly, _} = parse_expression(Tokens),
    Poly.

parse_expression(Tokens) ->
    {LeftPoly, Tokens1} = parse_term(Tokens),
    parse_expression_rest(LeftPoly, Tokens1).

parse_expression_rest(CurrentPoly, [{op, '+'}|Tokens]) ->
    {RightPoly, Tokens1} = parse_term(Tokens),
    parse_expression_rest(poly_add(CurrentPoly, RightPoly), Tokens1);
parse_expression_rest(CurrentPoly, [{op, '-'}|Tokens]) ->
    {RightPoly, Tokens1} = parse_term(Tokens),
    parse_expression_rest(poly_sub(CurrentPoly, RightPoly), Tokens1);
parse_expression_rest(CurrentPoly, Tokens) ->
    {CurrentPoly, Tokens}.

parse_term(Tokens) ->
    {LeftPoly, Tokens1} = parse_factor(Tokens),
    parse_term_rest(LeftPoly, Tokens1).

parse_term_rest(CurrentPoly, [{op, '*'}|Tokens]) ->
    {RightPoly, Tokens1} = parse_factor(Tokens),
    parse_term_rest(poly_mul(CurrentPoly, RightPoly), Tokens1);
parse_term_rest(CurrentPoly, Tokens) ->
    {CurrentPoly, Tokens}.

parse_factor([{op, '-'}, Tokens]) -> % Unary minus
    {Poly, RestTokens} = parse_factor(Tokens),
    {poly_mul(Poly, poly_new({}, -1)), RestTokens};
parse_factor([{int, N}|Tokens]) ->
    {poly_new({}, N), Tokens};
parse_factor([{var, Name}|Tokens]) ->
    {poly_new({Name}, 1), Tokens};
parse_factor([{paren, '('}|Tokens]) ->
    {Poly, Tokens1} = parse_expression(Tokens),
    case Tokens1 of
        [{paren, ')'}|RestTokens] -> {Poly, RestTokens};
        _ -> error(syntax_error_expected_closing_paren)
    end;
parse_factor([]) -> error(syntax_error_unexpected_end_of_input);
parse_factor([Token|_]) -> error({syntax_error_unexpected_token, Token}).

poly_to_string_list(Poly) ->
    TermsList = maps:fold(
        fun(Term, Coeff, Acc) ->
            case Coeff of
                0 -> Acc;
                _ -> [{Term, Coeff}|Acc]
            end
        end,
        [],
        Poly
    ),
    SortedTerms = lists:sort(fun sort_terms/2, TermsList),
    lists:map(fun format_term/1, SortedTerms).

sort_terms({Term1, _}, {Term2, _}) ->
    Len1 = tuple_size(Term1),
    Len2 = tuple_size(Term2),
    if
        Len1 > Len2 -> true; % Higher degree first
        Len1 < Len2 -> false;
        true -> Term1 < Term2 % Same degree, alphabetical by term tuple
    end.

format_term({Term, Coeff}) ->
    case tuple_to_list(Term) of
        [] -> integer_to_list(Coeff); % Constant term
        Vars ->
            VarStr = string:join(Vars, "*"),
            case Coeff of
                1 -> VarStr;
                -1 -> "-" ++ VarStr;
                _ -> io_lib:format("~p*~s", [Coeff, VarStr])
            end
    end.

basic_calculator_iv(Expression, EvalMapList) ->
    EvalMap = maps:from_list(EvalMapList),
    Tokens = tokenize(Expression),
    ParsedPoly = parse(Tokens),
    EvaluatedPoly = poly_eval(ParsedPoly, EvalMap),
    poly_to_string_list(EvaluatedPoly).