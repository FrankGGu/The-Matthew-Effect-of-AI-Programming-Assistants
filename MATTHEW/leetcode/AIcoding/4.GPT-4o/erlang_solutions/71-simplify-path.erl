-spec simplify_path(Path :: unicode:unicode_binary()) -> unicode:unicode_binary().
simplify_path(Path) ->
    simplify_path(Path, []).

simplify_path(<<"/">>, Acc) -> 
    lists:reverse(Acc);
simplify_path(<<"/", Rest/binary>>, Acc) ->
    simplify_path(Rest, Acc);
simplify_path(<<"/..", Rest/binary>>, [_ | Acc]) -> 
    simplify_path(Rest, Acc);
simplify_path(<<"/.", Rest/binary>>, Acc) -> 
    simplify_path(Rest, Acc);
simplify_path(<<"/", Dir/binary, Rest/binary>>, Acc) when Dir /= <<>> ->
    simplify_path(Rest, [Dir | Acc]);
simplify_path(_, Acc) -> 
    lists:reverse(Acc).
