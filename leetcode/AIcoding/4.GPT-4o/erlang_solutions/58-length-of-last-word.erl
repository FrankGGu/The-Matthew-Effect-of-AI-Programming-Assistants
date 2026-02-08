-spec length_of_last_word(S :: unicode:unicode_binary()) -> integer().
length_of_last_word(S) ->
    S1 = lists:reverse(string:tokens(string:trim(S), " ")),
    case S1 of
        [LastWord | _] -> length(LastWord);
        [] -> 0
    end.
