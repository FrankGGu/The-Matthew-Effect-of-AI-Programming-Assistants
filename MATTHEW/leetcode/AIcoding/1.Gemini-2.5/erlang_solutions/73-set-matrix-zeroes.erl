-module(solution).
-export([set_matrix_zeroes/1]).

set_matrix_zeroes(Matrix) ->
    {M, N} = get_dimensions(Matrix),
    {R_zeros, C_zeros} = find_zero_indices(Matrix, M, N),
    build_new_matrix(Matrix, M, N, R_zeros, C_zeros).

get_dimensions(Matrix) ->
    M = length(Matrix),
    N = case M > 0 of
            true -> length(hd(Matrix));
            false -> 0
        end,
    {M, N}.

find_zero_indices(Matrix, M, N) ->
    R_zeros = sets:new(),
    C_zeros = sets:new(),
    find_zero_indices_recursive(Matrix, 0, M, N, R_zeros, C_zeros).

find_zero_indices_recursive([], _RowIdx, _M, _N, R_zeros, C_zeros) ->
    {R_zeros, C_zeros};
find_zero_indices_recursive([Row | RestRows], RowIdx, M, N, R_zeros_acc, C_zeros_acc) ->
    {New_R_zeros_acc, New_C_zeros_acc} = find_zero_indices_in_row(Row, RowIdx, 0, N, R_zeros_acc, C_zeros_acc),
    find_zero_indices_recursive(RestRows, RowIdx + 1, M, N, New_R_zeros_acc, New_C_zeros_acc).

find_zero_indices_in_row([], _RowIdx, _ColIdx, _N, R_zeros_acc, C_zeros_acc) ->
    {R_zeros_acc, C_zeros_acc};
find_zero_indices_in_row([Element | RestElements], RowIdx, ColIdx, N, R_zeros_acc, C_zeros_acc) ->
    case Element of
        0 ->
            Updated_R_zeros = sets:add_element(RowIdx, R_zeros_acc),
            Updated_C_zeros = sets:add_element(ColIdx, C_zeros_acc),
            find_zero_indices_in_row(RestElements, RowIdx, ColIdx + 1, N, Updated_R_zeros, Updated_C_zeros);
        _ ->
            find_zero_indices_in_row(RestElements, RowIdx, ColIdx + 1, N, R_zeros_acc, C_zeros_acc)
    end.

build_new_matrix(Matrix, M, N, R_zeros, C_zeros) ->
    build_new_matrix_recursive(Matrix, 0, M, N, R_zeros, C_zeros, []).

build_new_matrix_recursive([], _RowIdx, _M, _N, _R_zeros, _C_zeros, AccMatrix) ->
    lists:reverse(AccMatrix);
build_new_matrix_recursive([Row | RestRows], RowIdx, M, N, R_zeros, C_zeros, AccMatrix) ->
    NewRow = case sets:is_element(RowIdx, R_zeros) of
                 true ->
                     list_of_zeros(N);
                 false ->
                     build_new_row(Row, 0, N, C_zeros, [])
             end,
    build_new_matrix_recursive(RestRows, RowIdx + 1, M, N, R_zeros, C_zeros, [NewRow | AccMatrix]).

build_new_row([], _ColIdx, _N, _C_zeros, AccRow) ->
    lists:reverse(AccRow);
build_new_row([Element | RestElements], ColIdx, N, C_zeros, AccRow) ->
    NewElement = case sets:is_element(ColIdx, C_zeros) of
                     true -> 0;
                     false -> Element
                 end,
    build_new_row(RestElements, ColIdx + 1, N, C_zeros, [NewElement | AccRow]).

list_of_zeros(N) ->
    lists:duplicate(N, 0).