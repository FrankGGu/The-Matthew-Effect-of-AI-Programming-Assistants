-spec brace_expansion_ii(Expression :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
brace_expansion_ii(Expression) ->
    S = unicode:characters_to_list(Expression),
    {Res, _} = parse(S),
    lists:usort(Res).

parse(S) ->
    {Res, Rest} = parse_expr(S),
    case Rest of
        [] -> {Res, []};
        _ -> 
            {Res2, Rest2} = parse(Rest),
            {cross(Res, Res2), Rest2}
    end.

parse_expr([${ | Rest]) ->
    {Res, [} | Rest2]} = parse_list(Rest),
    {Res, Rest2};
parse_expr([C | Rest]) when C =/= ${, C =/= $}, C =/= $, ->
    {[ [C] ], Rest}.

parse_list(S) ->
    {First, Rest} = parse(S),
    case Rest of
        [$, | Rest2] ->
            {Second, Rest3} = parse_list(Rest2),
            {union(First, Second), Rest3};
        _ ->
            {First, Rest}
    end.

union(A, B) -> A ++ B.

cross(A, B) ->
    [ X ++ Y || X <- A, Y <- B ].