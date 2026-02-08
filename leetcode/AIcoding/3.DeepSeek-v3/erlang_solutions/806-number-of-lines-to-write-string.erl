-spec number_of_lines(widths :: [integer()], s :: unicode:unicode_binary()) -> [integer()].
number_of_lines(Widths, S) ->
    {Lines, Current} = lists:foldl(fun(Char, {L, C}) ->
        Width = lists:nth(Char - $a + 1, Widths),
        if
            C + Width > 100 -> {L + 1, Width};
            true -> {L, C + Width}
        end
    end, {1, 0}, unicode:characters_to_list(S)),
    [Lines, Current].