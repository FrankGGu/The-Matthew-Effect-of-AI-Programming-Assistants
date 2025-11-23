-spec dominant_substrings(S :: unicode:unicode_binary()) -> integer().
dominant_substrings(S) ->
    SList = binary_to_list(S),
    dominant_substrings(SList, 0, 0, 0).

dominant_substrings([], _zeros, _ones, Acc) ->
    Acc;
dominant_substrings([$1 | Rest], Zeros, Ones, Acc) ->
    NewOnes = Ones + 1,
    NewAcc = Acc + NewOnes,
    dominant_substrings(Rest, Zeros, NewOnes, NewAcc);
dominant_substrings([$0 | Rest], Zeros, Ones, Acc) ->
    NewZeros = Zeros + 1,
    case NewZeros > Ones of
        true -> dominant_substrings(Rest, NewZeros, Ones, Acc);
        false -> dominant_substrings(Rest, NewZeros, Ones, Acc + Ones - NewZeros + 1)
    end.