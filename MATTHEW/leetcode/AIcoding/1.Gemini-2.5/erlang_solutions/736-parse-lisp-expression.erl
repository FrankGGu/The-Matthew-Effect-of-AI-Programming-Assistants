-module(solution).
-export([evaluate_expression/1]).

evaluate_expression(ExpressionString) ->
    Tokens = tokenize(ExpressionString),
    {ParsedExp, _RemainingTokens} = read_expression(Tokens),
    eval(ParsedExp, maps:new()).

tokenize(String) ->
    tokenize(String, <<>>, []).

tokenize(<<C, Rest/binary>>, Acc, Tokens) when C == $  ->
    tokenize_flush(Acc, Tokens, Rest);
tokenize(<<C, Rest/binary>>, Acc, Tokens) when C == $( ->
    tokenize_flush(Acc, Tokens, Rest, open_paren);
tokenize(<<C, Rest/binary>>, Acc, Tokens) when C == $) ->
    tokenize_flush(Acc, Tokens, Rest, close_paren);
tokenize(<<C, Rest/binary>>, Acc, Tokens) ->
    tokenize(Rest, <<Acc/binary, C>>, Tokens);
tokenize(<<>>, Acc, Tokens) ->
    lists:reverse(tokenize_flush(Acc, Tokens, <<>>)).

tokenize_flush(<<>>, Tokens, Rest) ->
    tokenize(Rest, <<>>, Tokens);
tokenize_flush(Acc, Tokens, Rest) ->
    Token = parse_token(Acc),
    tokenize(Rest, <<>>, [Token | Tokens]).

tokenize_flush(<<>>, Tokens, Rest, SpecialToken) ->
    tokenize(Rest, <<>>, [SpecialToken | Tokens]);
tokenize_flush(Acc, Tokens, Rest, SpecialToken) ->
    Token = parse_token(Acc),
    tokenize(Rest, <<>>, [SpecialToken, Token | Tokens]).

parse_token(TokenBin) ->
    case catch binary_to_integer(TokenBin) of
        N when is_integer(N) -> {integer, N};
        _ -> {binary, TokenBin}
    end.

read_expression(Tokens) ->
    [Token | Rest] = Tokens,
    case Token of
        open_paren ->
            {ListElements, RemainingAfterList} = read_list_elements(Rest),
            case ListElements of
                [{binary, <<"add">>}, Exp1, Exp2] -> {{add, Exp1, Exp2}, RemainingAfterList};
                [{binary, <<"mult">>}, Exp1, Exp2] -> {{mult, Exp1, Exp2}, RemainingAfterList};
                [{binary, <<"let">>}, _ | _] = LetExpressionList ->
                    LetArgs = tl(LetExpressionList),
                    {Bindings, LastExp} = parse_let_bindings_and_last_exp(LetArgs),
                    {{let, Bindings, LastExp}, RemainingAfterList};
                _ -> error("Invalid list expression")
            end;
        {integer, N} -> {N, Rest};
        {binary, Var} -> {Var, Rest};
        _ -> error("Unexpected token")
    end.

read_list_elements(Tokens) ->
    read_list_elements(Tokens, []).

read_list_elements([close_paren | Rest], Acc) ->
    {lists:reverse(Acc), Rest};
read_list_elements(Tokens, Acc) ->
    {Exp, Remaining} = read_expression(Tokens),
    read_list_elements(Remaining, [Exp | Acc]).

parse_let_bindings_and_last_exp(Elements) ->
    Len = length(Elements),
    if (Len rem 2) == 1 ->
        LastExp = lists:last(Elements),
        BindingsList = lists:droplast(Elements),
        Bindings = parse_let_bindings_pairs(BindingsList),
        {Bindings, LastExp};
    true ->
        error("Invalid let expression arguments count")
    end.

parse_let_bindings_pairs([{binary, Var}, Exp | Rest]) ->
    [{Var, Exp} | parse_let_bindings_pairs(Rest)];
parse_let_bindings_pairs([]) ->
    [].

eval(N, _Env) when is_integer(N) ->
    N;
eval(Var, Env) when is_binary(Var) ->
    maps:get(Var, Env);
eval({add, Exp1, Exp2}, Env) ->
    eval(Exp1, Env) + eval(Exp2, Env);
eval({mult, Exp1, Exp2}, Env) ->
    eval(Exp1, Env) * eval(Exp2, Env);
eval({let, Bindings, LastExp}, Env) ->
    NewEnv = lists:foldl(fun({Var, ValExp}, CurrentEnv) ->
                                 Val = eval(ValExp, CurrentEnv),
                                 maps:put(Var, Val, CurrentEnv)
                         end, Env, Bindings),
    eval(LastExp, NewEnv).