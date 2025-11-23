-module(solution).
-export([braceExpansionII/1]).

braceExpansionII(Expression) ->
    {Result, []} = parse_level_0(Expression),
    ordsets:to_list(Result).

parse_level_0(String) ->
    case parse_level_1(String) of
        {Term, Rest1} ->
            parse_level_0_rest(Rest1, Term);
        {no_match, Rest} ->
            {ordsets:new(), Rest}
    end.

parse_level_0_rest([], Acc) ->
    {Acc, []};
parse_level_0_rest([Char | _] = Rest, Acc) when Char == $} or Char == $, ->
    {Acc, Rest};
parse_level_0_rest(Rest, Acc) ->
    case parse_level_1(Rest) of
        {NextTerm, Rest2} ->
            NewAcc = cartesian_product(Acc, NextTerm),
            parse_level_0_rest(Rest2, NewAcc);
        {no_match, _} ->
            {Acc, Rest}
    end.

parse_level_1([${ | Rest]) ->
    parse_braces([${ | Rest]);
parse_level_1([Char | Rest]) when Char >= $a and Char <= $z ->
    {ordsets:from_list([[Char]]), Rest};
parse_level_1(String) ->
    {no_match, String}.

parse_braces([${ | Rest]) ->
    {UnionResult, [$} | Rest2]} = parse_union(Rest),
    {UnionResult, Rest2}.

parse_union(String) ->
    {Expr1, Rest1} = parse_level_0(String),
    parse_union_rest(Rest1, Expr1).

parse_union_rest([$, | Rest], Acc) ->
    {Expr2, Rest2} = parse_level_0(Rest),
    NewAcc = ordsets:union(Acc, Expr2),
    parse_union_rest(Rest2, NewAcc);
parse_union_rest(Rest, Acc) ->
    {Acc, Rest}.

cartesian_product(Set1, Set2) ->
    ordsets:from_list([X ++ Y || X <- ordsets:to_list(Set1), Y <- ordsets:to_list(Set2)]).