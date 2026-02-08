-spec max_consecutive_answers(AnswerKey :: unicode:unicode_binary(), K :: integer()) -> integer().
max_consecutive_answers(AnswerKey, K) ->
    Bin = unicode:characters_to_binary(AnswerKey),
    max_consec(Bin, K, $T, 0, 0, 0).

max_consec(Bin, K, Target, Left, Right, Max) when Right < byte_size(Bin) ->
    Current = binary:at(Bin, Right),
    K1 = if Current =/= Target -> K - 1; true -> K end,
    if K1 >= 0 ->
           max_consec(Bin, K1, Target, Left, Right + 1, max(Max, Right - Left + 1));
       true ->
           CurrentLeft = binary:at(Bin, Left),
           K2 = if CurrentLeft =/= Target -> K1 + 1; true -> K1 end,
           max_consec(Bin, K2, Target, Left + 1, Right, Max)
    end;
max_consec(_, _, _, _, _, Max) -> Max.

-spec max_consecutive_answers(AnswerKey :: unicode:unicode_binary(), K :: integer()) -> integer().
max_consecutive_answers(AnswerKey, K) ->
    MaxT = max_consec(AnswerKey, K, $T, 0, 0, 0),
    MaxF = max_consec(AnswerKey, K, $F, 0, 0, 0),
    max(MaxT, MaxF).