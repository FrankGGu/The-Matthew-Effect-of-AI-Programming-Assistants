-spec capture_forts(Forts :: [integer()]) -> integer().
capture_forts(Forts) ->
    capture_forts(Forts, 0, 0, 0, 0).

capture_forts([], _Pos, _Last1, _LastNeg1, Max) -> Max;
capture_forts([0 | T], Pos, Last1, LastNeg1, Max) ->
    capture_forts(T, Pos + 1, Last1, LastNeg1, Max);
capture_forts([1 | T], Pos, Last1, _LastNeg1, Max) ->
    NewMax = if 
        LastNeg1 > 0 -> max(Max, Pos - LastNeg1 - 1);
        true -> Max
    end,
    capture_forts(T, Pos + 1, Pos, 0, NewMax);
capture_forts([-1 | T], Pos, Last1, LastNeg1, Max) ->
    NewMax = if 
        Last1 > 0 -> max(Max, Pos - Last1 - 1);
        true -> Max
    end,
    capture_forts(T, Pos + 1, 0, Pos, NewMax).