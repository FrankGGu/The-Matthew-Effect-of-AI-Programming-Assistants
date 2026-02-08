-spec calculate_score(Instructions :: [integer()], StartPos :: integer()) -> integer().
calculate_score(Instructions, StartPos) ->
    Score = 0,
    calculate_score(Instructions, StartPos, Score).

calculate_score([], _, Score) ->
    Score;
calculate_score([Inst | Rest], Pos, Score) ->
    case Inst of
        0 -> 
            NewPos = Pos - 1,
            NewScore = Score + (if NewPos == -1 -> 1; true -> 0 end),
            calculate_score(Rest, NewPos, NewScore);
        1 -> 
            NewPos = Pos + 1,
            NewScore = Score + (if NewPos == 1 -> 1; true -> 0 end),
            calculate_score(Rest, NewPos, NewScore)
    end.