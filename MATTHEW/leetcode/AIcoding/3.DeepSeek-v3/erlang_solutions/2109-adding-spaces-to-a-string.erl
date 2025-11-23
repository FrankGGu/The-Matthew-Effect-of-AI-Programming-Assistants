-spec add_spaces(S :: unicode:unicode_binary(), Spaces :: [integer()]) -> unicode:unicode_binary().
add_spaces(S, Spaces) ->
    add_spaces(S, Spaces, 0, []).

add_spaces(S, [], _Pos, Acc) ->
    unicode:characters_to_binary(lists:reverse(Acc) ++ binary_to_list(S));
add_spaces(<<Char/utf8, Rest/binary>>, [SpacePos | RestSpaces], Pos, Acc) when Pos == SpacePos ->
    add_spaces(Rest, RestSpaces, Pos + 1, [$\s, Char | Acc]);
add_spaces(<<Char/utf8, Rest/binary>>, Spaces, Pos, Acc) ->
    add_spaces(Rest, Spaces, Pos + 1, [Char | Acc]).