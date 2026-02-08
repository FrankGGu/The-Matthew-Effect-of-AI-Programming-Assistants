-spec plus_one(Digits :: [integer()]) -> [integer()].
plus_one(Digits) ->
    plus_one(Digits, 1, []).

plus_one([], Carry, Acc) ->
    case Carry of
        0 -> lists:reverse(Acc);
        1 -> lists:reverse([1 | Acc])
    end;
plus_one([Digit | Rest], Carry, Acc) ->
    Sum = Digit + Carry,
    case Sum of
        10 -> plus_one(Rest, 1, [0 | Acc]);
        _ -> plus_one(Rest, 0, [Sum | Acc])
    end.