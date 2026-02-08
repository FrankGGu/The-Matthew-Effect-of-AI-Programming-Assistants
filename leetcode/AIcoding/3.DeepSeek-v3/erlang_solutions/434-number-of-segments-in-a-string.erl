-spec count_segments(S :: unicode:unicode_binary()) -> integer().
count_segments(S) ->
    case string:trim(S) of
        <<>> -> 0;
        Trimmed ->
            Words = string:split(Trimmed, " ", all),
            length(Words)
    end.