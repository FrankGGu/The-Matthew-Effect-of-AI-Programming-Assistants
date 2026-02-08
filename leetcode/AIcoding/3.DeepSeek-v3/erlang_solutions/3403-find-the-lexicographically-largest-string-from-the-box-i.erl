-spec largest_lex_string(Box :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
largest_lex_string(Box) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, Box),
    case Sorted of
        [] -> <<>>;
        [H | _] -> H
    end.