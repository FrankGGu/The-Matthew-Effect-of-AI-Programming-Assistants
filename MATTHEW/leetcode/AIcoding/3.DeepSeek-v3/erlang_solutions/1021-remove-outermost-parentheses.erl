-spec remove_outer_parentheses(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
remove_outer_parentheses(S) ->
    remove_outer_parentheses(S, 0, 0, <<>>).

remove_outer_parentheses(<<>>, _, _, Acc) -> Acc;
remove_outer_parentheses(<<"(", Rest/binary>>, 0, 0, Acc) ->
    remove_outer_parentheses(Rest, 1, 1, Acc);
remove_outer_parentheses(<<"(", Rest/binary>>, Level, Start, Acc) ->
    remove_outer_parentheses(Rest, Level + 1, Start + 1, <<Acc/binary, "(">>);
remove_outer_parentheses(<<")", Rest/binary>>, 1, 1, Acc) ->
    remove_outer_parentheses(Rest, 0, 0, Acc);
remove_outer_parentheses(<<")", Rest/binary>>, Level, Start, Acc) ->
    remove_outer_parentheses(Rest, Level - 1, Start, <<Acc/binary, ")">>).