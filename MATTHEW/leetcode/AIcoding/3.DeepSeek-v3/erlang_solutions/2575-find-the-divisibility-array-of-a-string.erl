-spec divisibility_array(Word :: unicode:unicode_binary(), M :: integer()) -> [integer()].
divisibility_array(Word, M) ->
    N = byte_size(Word),
    Result = lists:foldl(fun(I, {Acc, Remainder}) ->
        Digit = binary:at(Word, I) - $0,
        NewRemainder = (Remainder * 10 + Digit) rem M,
        NewAcc = case NewRemainder of
            0 -> [1 | Acc];
            _ -> [0 | Acc]
        end,
        {NewAcc, NewRemainder}
    end, {[], 0}, lists:seq(0, N - 1)),
    lists:reverse(element(1, Result)).