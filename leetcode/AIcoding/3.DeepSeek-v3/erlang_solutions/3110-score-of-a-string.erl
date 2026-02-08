-spec score_of_string(S :: unicode:unicode_binary()) -> integer().
score_of_string(S) ->
    score_of_string(S, 0, 0).

score_of_string(<<>>, _Prev, Acc) ->
    Acc;
score_of_string(<<C, Rest/binary>>, Prev, Acc) ->
    Current = C,
    Diff = abs(Current - Prev),
    NewAcc = if
        Prev =:= 0 -> Acc;
        true -> Acc + Diff
    end,
    score_of_string(Rest, Current, NewAcc).