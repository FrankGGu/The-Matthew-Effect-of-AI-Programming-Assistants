-spec maximum_score(A :: integer(), B :: integer(), C :: integer()) -> integer().
maximum_score(A, B, C) ->
    [X, Y, Z] = lists:sort([A, B, C]),
    min(X + Y, (X + Y + Z) div 2).