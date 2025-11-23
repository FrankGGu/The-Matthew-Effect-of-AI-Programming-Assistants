-module(brace_expansion_ii).
-export([brace_expansion_ii/1]).

brace_expansion_ii(Expression) ->
    {ok, Tokens, _} = erl_scan:string(Expression ++ "."),
    Expressions = parse(Tokens),
    Result = evaluate(Expressions),
    lists:sort(lists:usort(Result)).

parse(Tokens) ->
    parse(Tokens, []).

parse([{'atom', _, ','} | Rest], Acc) ->
    parse(Rest, [',', Acc]);
parse([{'atom', _, '{'} | Rest], Acc) ->
    {Expr, Rest2} = parse_group(Rest),
    parse(Rest2, [Acc, Expr]);
parse([{'atom', _, String} | Rest], Acc) ->
    parse(Rest, [Acc, String]);
parse([{'atom', _, '}'} | Rest], Acc) ->
    {Acc, Rest};
parse([{'atom', _, '.'}], Acc) ->
    Acc.

parse_group(Tokens) ->
    parse(Tokens, []).

evaluate(Expressions) ->
    evaluate(Expressions, []).

evaluate([], Acc) ->
    Acc;
evaluate([',' | Rest], Acc) ->
    evaluate(Rest, Acc);
evaluate([List1, List2 | Rest], Acc) when is_list(List1), is_list(List2) ->
    Combined = [S1 ++ S2 || S1 <- List1, S2 <- List2],
    evaluate([Combined | Rest], Acc);
evaluate([String1, String2 | Rest], Acc) when is_list(String1), is_atom(String2) ->
    Combined = [S1 ++ atom_to_list(String2) || S1 <- String1],
    evaluate([Combined | Rest], Acc);
evaluate([String1, String2 | Rest], Acc) when is_atom(String1), is_list(String2) ->
    Combined = [atom_to_list(String1) ++ S2 || S2 <- String2],
    evaluate([Combined | Rest], Acc);
evaluate([String1, String2 | Rest], Acc) when is_atom(String1), is_atom(String2) ->
    evaluate([[atom_to_list(String1) ++ atom_to_list(String2)] | Rest], Acc);
evaluate([List | Rest], Acc) when is_list(List) ->
    evaluate(Rest, Acc ++ List);
evaluate([String | Rest], Acc) when is_atom(String) ->
    evaluate(Rest, Acc ++ [atom_to_list(String)]).