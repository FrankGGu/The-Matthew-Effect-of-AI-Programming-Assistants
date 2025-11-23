-spec score_of_parentheses(S :: unicode:unicode_binary()) -> integer().
score_of_parentheses(S) ->
    score(S, 0, 0).

score(<<>>, _, Acc) -> Acc;
score(<<"(", Rest/binary>>, Depth, Acc) ->
    score(Rest, Depth + 1, Acc);
score(<<")", Rest/binary>>, Depth, Acc) when Depth > 0 ->
    case Rest of
        <<"(", _/binary>> -> score(Rest, Depth - 1, Acc);
        _ -> score(Rest, Depth - 1, Acc + (1 bsl (Depth - 1)))
    end.