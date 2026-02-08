-module(solution).
-export([can_disconnect/1]).

can_disconnect(Matrix) ->
    N = length(Matrix),
    M = length(hd(Matrix)),
    can_disconnect_helper(Matrix, N, M, 0, 0, false).

can_disconnect_helper(Matrix, N, M, X, Y, Flipped) when X < N, Y < M ->
    case lists:nth(Y + 1, lists:nth(X + 1, Matrix)) of
        0 -> 
            true;
        1 when Flipped =:= false ->
            can_disconnect_helper(Matrix, N, M, X + 1, Y, true) orelse 
            can_disconnect_helper(Matrix, N, M, X, Y + 1, true) orelse 
            can_disconnect_helper(Matrix, N, M, X, Y + 1, Flipped) orelse 
            can_disconnect_helper(Matrix, N, M, X + 1, Y, Flipped);
        1 -> 
            can_disconnect_helper(Matrix, N, M, X + 1, Y, Flipped) orelse 
            can_disconnect_helper(Matrix, N, M, X, Y + 1, Flipped)
    end;
can_disconnect_helper(_, _, _, _, _, _) -> 
    false.