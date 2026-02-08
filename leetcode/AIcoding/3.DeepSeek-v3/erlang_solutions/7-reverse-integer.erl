-spec reverse(X :: integer()) -> integer().
reverse(X) ->
    Max = 2147483647,
    Min = -2147483648,
    AbsX = abs(X),
    Reversed = list_to_integer(lists:reverse(integer_to_list(AbsX)) * case X < 0 of true -> -1; false -> 1 end,
    if 
        Reversed > Max -> 0;
        Reversed < Min -> 0;
        true -> Reversed
    end.