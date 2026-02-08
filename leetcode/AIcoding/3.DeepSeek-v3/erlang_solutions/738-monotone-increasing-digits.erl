-spec monotone_increasing_digits(N :: integer()) -> integer().
monotone_increasing_digits(N) ->
    Chars = integer_to_list(N),
    Len = length(Chars),
    {NewChars, _} = process(Chars, Len, Len),
    list_to_integer(NewChars).

process(Chars, Len, Pos) when Pos =< 1 ->
    {Chars, false};
process(Chars, Len, Pos) ->
    Prev = lists:nth(Pos - 1, Chars),
    Current = lists:nth(Pos, Chars),
    if
        Prev > Current ->
            NewChars = decrease_and_set_nines(Chars, Pos - 1, Len),
            {NewChars, true};
        true ->
            {NewChars, Flag} = process(Chars, Len, Pos - 1),
            if
                Flag ->
                    PrevNew = lists:nth(Pos - 1, NewChars),
                    CurrentNew = lists:nth(Pos, NewChars),
                    if
                        PrevNew > CurrentNew ->
                            {decrease_and_set_nines(NewChars, Pos - 1, Len), true};
                        true ->
                            {NewChars, Flag}
                    end;
                true ->
                    {NewChars, Flag}
            end
    end.

decrease_and_set_nines(Chars, Pos, Len) ->
    Decreased = lists:sublist(Chars, Pos) ++ [lists:nth(Pos, Chars) - 1],
    Nines = lists:duplicate(Len - Pos, $9),
    Decreased ++ Nines.