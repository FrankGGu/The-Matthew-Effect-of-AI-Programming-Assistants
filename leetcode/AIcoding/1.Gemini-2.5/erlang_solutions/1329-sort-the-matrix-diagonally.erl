-module(solution).
-export([diagonal_sort/1]).

diagonal_sort(Mat) ->
    M = length(Mat),
    N = length(hd(Mat)),
    Diagonals = collect_diagonals(0, Mat, #{}),
    SortedDiagonals = maps:map(fun(_, L) -> lists:sort(L) end, Diagonals),
    build_matrix(0, M, N, SortedDiagonals, []).

collect_diagonals(I, [], AccDiagonals) ->
    AccDiagonals;
collect_diagonals(I, [Row | RestRows], AccDiagonals) ->
    NewAccDiagonals = collect_diagonals_cols(I, 0, Row, AccDiagonals),
    collect_diagonals(I + 1, RestRows, NewAccDiagonals).

collect_diagonals_cols(I, J, [], AccDiagonals) ->
    AccDiagonals;
collect_diagonals_cols(I, J, [Element | RestElements], AccDiagonals) ->
    Diff = I - J,
    UpdatedAccDiagonals = maps:update_with(Diff, fun(L) -> [Element | L] end, [Element], AccDiagonals),
    collect_diagonals_cols(I, J + 1, RestElements, UpdatedAccDiagonals).

build_matrix(I, M, N, CurrentDiagonals, AccMatrix) ->
    if I == M ->
        lists:reverse(AccMatrix);
    true ->
        {NewRowReversed, UpdatedDiagonals} = build_matrix_cols(I, 0, N, CurrentDiagonals, []),
        build_matrix(I + 1, M, N, UpdatedDiagonals, [lists:reverse(NewRowReversed) | AccMatrix])
    end.

build_matrix_cols(I, J, N, CurrentDiagonals, AccRow) ->
    if J == N ->
        {AccRow, CurrentDiagonals};
    true ->
        Diff = I - J,
        [H | T] = maps:get(Diff, CurrentDiagonals),
        UpdatedDiagonals = maps:put(Diff, T, CurrentDiagonals),
        build_matrix_cols(I, J + 1, N, UpdatedDiagonals, [H | AccRow])
    end.