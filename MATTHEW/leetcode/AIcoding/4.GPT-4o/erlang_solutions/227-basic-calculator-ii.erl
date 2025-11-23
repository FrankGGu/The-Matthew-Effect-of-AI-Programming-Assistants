-spec calculate(S :: unicode:unicode_binary()) -> integer().
calculate(S) ->
    calculate(S, 0, 0, 1).

calculate([], Res, _, _) -> Res;
calculate([H | T], Res, LastNum, LastOp) when H == $+ ; H == $- ; H == $* ; H == $/ ->
    NewOp = case H of
                $+ -> 1;
                $- -> -1;
                $* -> 0;
                $/ -> 0
            end,
    calculate(T, Res, LastNum, NewOp);
calculate([H | T], Res, LastNum, LastOp) when H >= $0, H =< $9 ->
    NewLastNum = LastNum * 10 + (H - $0),
    calculate(T, Res, NewLastNum, LastOp);
calculate([H | T], Res, LastNum, 0) when LastOp == 0 ->
    case H of
        $* -> calculate(T, Res, LastNum * (H - $0), 0);
        $/ -> calculate(T, Res, LastNum div (H - $0), 0);
    end;
calculate([H | T], Res, LastNum, LastOp) ->
    calculate(T, Res + LastOp * LastNum, 0, 1).
