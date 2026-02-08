-spec remove_invalid_parentheses(S :: unicode:unicode_binary()) -> [unicode:unicode_binary()].

remove_invalid_parentheses(S) ->
    remove_invalid_parentheses(S, 0, 0, [], []).

remove_invalid_parentheses([], _, _, Acc, Acc) -> Acc;
remove_invalid_parentheses([H | T], Left, Right, Acc, Res) when H == $\) ->
    remove_invalid_parentheses(T, Left, Right + 1, Acc, Res);
remove_invalid_parentheses([H | T], Left, Right, Acc, Res) when H == $\( ->
    remove_invalid_parentheses(T, Left + 1, Right, Acc, Res);
remove_invalid_parentheses([H | T], Left, Right, Acc, Res) when Left > Right ->
    remove_invalid_parentheses(T, Left, Right, Acc ++ [H], Res);
remove_invalid_parentheses([H | T], Left, Right, Acc, Res) when Left >= Right ->
    remove_invalid_parentheses(T, Left, Right, Acc ++ [H], Res);
remove_invalid_parentheses([_ | T], Left, Right, Acc, Res) ->
    remove_invalid_parentheses(T, Left, Right, Acc, Res).
