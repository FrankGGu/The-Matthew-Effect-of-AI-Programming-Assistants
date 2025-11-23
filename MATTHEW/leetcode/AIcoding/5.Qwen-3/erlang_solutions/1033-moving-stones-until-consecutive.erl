-module(moving_stones_until_consecutive).
-export([num_moves_stones/3]).

num_moves_stones(A, B, C) ->
    [X, Y, Z] = lists:sort([A, B, C]),
    if
        Z - X == 2 -> 1;
        Y - X == 1 andalso Z - Y == 1 -> 0;
        true ->
            case (Y - X > 1) andalso (Z - Y > 1) of
                true -> 2;
                false -> 1
            end
    end.