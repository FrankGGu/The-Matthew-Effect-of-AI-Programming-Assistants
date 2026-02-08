-spec is_winner(Player1 :: [integer()], Player2 :: [integer()]) -> integer().
is_winner(Player1, Player2) ->
    Score1 = calculate_score(Player1),
    Score2 = calculate_score(Player2),
    if
        Score1 > Score2 -> 1;
        Score2 > Score1 -> 2;
        true -> 0
    end.

calculate_score(Rolls) ->
    calculate_score(Rolls, 0, 1).

calculate_score([], Acc, _) ->
    Acc;
calculate_score([_ | _] = Rolls, Acc, Frame) when Frame > 10 ->
    Acc;
calculate_score([Roll1, Roll2 | Rest], Acc, Frame) when Roll1 + Roll2 < 10 ->
    calculate_score(Rest, Acc + Roll1 + Roll2, Frame + 1);
calculate_score([Roll1, Roll2, Roll3 | Rest], Acc, Frame) when Roll1 == 10 ->
    NewAcc = Acc + Roll1 + Roll2 + Roll3,
    calculate_score([Roll2, Roll3 | Rest], NewAcc, Frame + 1);
calculate_score([Roll1, Roll2, Roll3 | Rest], Acc, Frame) when Roll1 + Roll2 == 10 ->
    NewAcc = Acc + Roll1 + Roll2 + Roll3,
    calculate_score([Roll3 | Rest], NewAcc, Frame + 1);
calculate_score([Roll1, Roll2], Acc, Frame) when Roll1 == 10 ->
    Acc + Roll1 + Roll2;
calculate_score([Roll1, Roll2], Acc, Frame) when Roll1 + Roll2 == 10 ->
    Acc + Roll1 + Roll2;
calculate_score([Roll1, Roll2], Acc, Frame) ->
    Acc + Roll1 + Roll2.