-spec maximum_score(A :: integer(), B :: integer(), C :: integer()) -> integer().
maximum_score(A, B, C) ->
    [X, Y, Z] = lists:sort([A, B, C]),
    case X + Y =< Z of
        true -> X + Y;
        false -> (X + Y + Z) div 2
    end.