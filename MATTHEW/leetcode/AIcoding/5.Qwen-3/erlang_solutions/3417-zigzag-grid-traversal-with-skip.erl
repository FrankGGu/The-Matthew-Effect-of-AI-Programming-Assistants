-module(zigzag_grid_traversal_with_skip).
-export([find_path/2]).

find_path(N, K) ->
    find_path(N, K, 1, 1, 0, []).

find_path(_, _, X, Y, _, Acc) when X > N orelse Y > N ->
    lists:reverse(Acc);
find_path(N, K, X, Y, Count, Acc) ->
    if
        Count == K ->
            find_path(N, K, X + 1, Y - 1, 0, Acc);
        true ->
            NewCount = Count + 1,
            NewAcc = [X * N + Y | Acc],
            case (X + Y) rem 2 of
                0 ->
                    find_path(N, K, X + 1, Y, NewCount, NewAcc);
                _ ->
                    find_path(N, K, X, Y + 1, NewCount, NewAcc)
            end
    end.