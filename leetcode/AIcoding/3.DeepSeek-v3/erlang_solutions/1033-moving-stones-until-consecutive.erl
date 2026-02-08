-spec num_moves_stones_until_consecutive(A :: integer(), B :: integer(), C :: integer()) -> [integer()].
num_moves_stones_until_consecutive(A, B, C) ->
    [X, Y, Z] = lists:sort([A, B, C]),
    Max = Z - X - 2,
    if
        Z - X == 2 -> [0, 0];
        Y - X =< 2 orelse Z - Y =< 2 -> [1, Max];
        true -> [2, Max]
    end.