-spec winner_of_game(Colors :: unicode:unicode_binary()) -> boolean().
winner_of_game(Colors) ->
    A = 0,
    B = 0,
    Len = byte_size(Colors),
    if Len < 3 -> false;
       true ->
            winner_of_game(Colors, 1, Len, A, B)
    end.

winner_of_game(Colors, I, Len, A, B) when I < Len - 1 ->
    C1 = binary:at(Colors, I - 1),
    C2 = binary:at(Colors, I),
    C3 = binary:at(Colors, I + 1),
    if C1 =:= C2, C2 =:= C3 ->
            if C1 =:= $A -> winner_of_game(Colors, I + 1, Len, A + 1, B);
               true -> winner_of_game(Colors, I + 1, Len, A, B + 1)
            end;
       true -> winner_of_game(Colors, I + 1, Len, A, B)
    end;
winner_of_game(_Colors, _I, _Len, A, B) ->
    A > B.