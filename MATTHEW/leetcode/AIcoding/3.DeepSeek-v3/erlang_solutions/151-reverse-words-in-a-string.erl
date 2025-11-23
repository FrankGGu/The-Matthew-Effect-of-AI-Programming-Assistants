-spec reverse_words(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
reverse_words(S) ->
    Words = string:split(S, " ", all),
    Reversed = lists:reverse(Words),
    string:join(Reversed, " ").