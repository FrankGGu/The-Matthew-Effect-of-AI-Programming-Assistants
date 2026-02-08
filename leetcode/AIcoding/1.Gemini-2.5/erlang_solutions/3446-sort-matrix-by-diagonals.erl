-module(solution).
-export([diagonalSort/1]).

diagonalSort(Mat) ->
    M = length(Mat),
    N = length(hd(Mat)),

    Diagonals = collect_diagonals(Mat),
    SortedDiagonals = sort_diagonal_lists(Diagonals),
    reconstruct_matrix(M, N, SortedDiagonals).

collect_diagonals(Mat) ->
    collect_diagonals_rows(0, Mat, maps:new()).

collect_diagonals_rows(R, [Row | RestRows], AccDiagonals) ->
    AccDiagonals2 = collect_diagonals_cols(R, 0, Row, AccDiagonals),
    collect_diagonals_rows(R + 1, RestRows, AccDiagonals2);
collect_diagonals_rows(_R, [], AccDiagonals) ->
    AccDiagonals.

collect_diagonals_cols(R, C, [Val | RestCols], AccDiagonals) ->
    K = R - C,
    UpdatedDiagonals = maps:update_with(K, fun(List) -> [Val | List] end, [Val], AccDiagonals),
    collect_diagonals_cols(R, C + 1, RestCols, UpdatedDiagonals);
collect_diagonals_cols(_R, _C, [], AccDiagonals) ->
    AccDiagonals.

sort_diagonal_lists(Diagonals) ->
    maps:map(fun(_K, List) -> lists:sort(List) end, Diagonals).

reconstruct_matrix(M, N, SortedDiagonals) ->
    lists:reverse(reconstruct_matrix_rows(0, M, N, SortedDiagonals, [])).

reconstruct_matrix_rows(R, M, N, SortedDiagonals, AccMatrix) when R < M ->
    {ReversedRow, UpdatedDiagonals} = reconstruct_matrix_cols(R, 0, N, SortedDiagonals, []),
    NewRow = lists:reverse(ReversedRow),
    reconstruct_matrix_rows(R + 1, M, N, UpdatedDiagonals, [NewRow | AccMatrix]);
reconstruct_matrix_rows(_R, _M, _N, _SortedDiagonals, AccMatrix) ->
    AccMatrix.

reconstruct_matrix_cols(R, C, N, SortedDiagonals, AccRow) when C < N ->
    K = R - C,
    List = maps:get(K, SortedDiagonals),
    [Val | RestList] = List,
    UpdatedDiagonals = maps:put(K, RestList, SortedDiagonals),
    reconstruct_matrix_cols(R, C + 1, N, UpdatedDiagonals, [Val | AccRow]);
reconstruct_matrix_cols(_R, _C, _N, SortedDiagonals, AccRow) ->
    {AccRow, SortedDiagonals}.