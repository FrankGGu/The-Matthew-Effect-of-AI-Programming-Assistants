-spec length_of_last_word(S :: unicode:unicode_binary()) -> integer().
length_of_last_word(S) ->
    Words = string:split(S, " ", all),
    Filtered = lists:filter(fun(W) -> W =/= "" end, Words),
    case Filtered of
        [] -> 0;
        _ -> string:length(lists:last(Filtered))
    end.