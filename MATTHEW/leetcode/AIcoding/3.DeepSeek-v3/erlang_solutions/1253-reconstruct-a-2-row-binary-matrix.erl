-spec reconstruct_matrix(Upper :: integer(), Lower :: integer(), Colsum :: [integer()]) -> [[integer()]].
reconstruct_matrix(Upper, Lower, Colsum) ->
    case lists:sum(Colsum) =:= Upper + Lower of
        false -> [];
        true ->
            reconstruct(Upper, Lower, Colsum, [], [])
    end.

reconstruct(_, _, [], UpperAcc, LowerAcc) ->
    [lists:reverse(UpperAcc), lists:reverse(LowerAcc)];
reconstruct(Upper, Lower, [Sum | Rest], UpperAcc, LowerAcc) ->
    case Sum of
        2 when Upper > 0, Lower > 0 ->
            reconstruct(Upper - 1, Lower - 1, Rest, [1 | UpperAcc], [1 | LowerAcc]);
        1 when Upper > Lower ->
            reconstruct(Upper - 1, Lower, Rest, [1 | UpperAcc], [0 | LowerAcc]);
        1 when Lower >= Upper ->
            reconstruct(Upper, Lower - 1, Rest, [0 | UpperAcc], [1 | LowerAcc]);
        0 ->
            reconstruct(Upper, Lower, Rest, [0 | UpperAcc], [0 | LowerAcc]);
        _ -> []
    end.