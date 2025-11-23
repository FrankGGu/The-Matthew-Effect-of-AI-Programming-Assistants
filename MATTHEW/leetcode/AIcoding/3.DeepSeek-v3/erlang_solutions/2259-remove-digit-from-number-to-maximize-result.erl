-spec remove_digit(Number :: unicode:unicode_binary(), Digit :: char()) -> unicode:unicode_binary().
remove_digit(Number, Digit) ->
    List = binary_to_list(Number),
    Candidates = remove_digit(List, Digit, [], []),
    lists:max(Candidates).

remove_digit([], _, _, Acc) ->
    Acc;
remove_digit([H | T], Digit, Prefix, Acc) when H =:= Digit ->
    NewNum = Prefix ++ T,
    remove_digit(T, Digit, Prefix ++ [H], [list_to_binary(NewNum) | Acc]);
remove_digit([H | T], Digit, Prefix, Acc) ->
    remove_digit(T, Digit, Prefix ++ [H], Acc).