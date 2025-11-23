-module(solution).
-export([find_diagonal_order/1]).

-spec find_diagonal_order([[integer()]]) -> [integer()].
find_diagonal_order(Mat) ->
    Diagonals = collect_diagonals(Mat, [], 0, 0),
    lists:flatten(Diagonals).

%% Collect diagonals from the matrix.
collect_diagonals([], Acc, _, _) -> Acc;
collect_diagonals([Row | Rest], Acc, I, J) ->
    Diagonal = collect_diagonal(Row, I, J, []),
    collect_diagonals(Rest, [Diagonal | Acc], I + 1, 0).

%% Collect one diagonal starting at position (I, J).
collect_diagonal([], _, _, Acc) -> Acc;
collect_diagonal([H | Rest], I, J, Acc) ->
    collect_diagonal(Rest, I + 1, J + 1, [H | Acc]).
