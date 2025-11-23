-module(sort_matrix_diagonals).
-export([diagonal_sort/1]).

diagonal_sort(Mat) ->
    {M, N} = matrix_size(Mat),
    sort_diagonals(Mat, M, N).

matrix_size(Mat) ->
    {length(Mat), length(hd(Mat))}.

sort_diagonals(Mat, M, N) ->
    SortedMat = lists:foldl(fun(K, Acc) -> sort_diagonal(Acc, K, 0, M, N) end, Mat, lists:seq(-(M - 1), N - 1)),
    SortedMat.

sort_diagonal(Mat, Row, Col, M, N) ->
    Diagonal = get_diagonal(Mat, Row, Col, M, N),
    SortedDiagonal = lists:sort(Diagonal),
    put_diagonal(Mat, SortedDiagonal, Row, Col, M, N).

get_diagonal(Mat, Row, Col, M, N) ->
    get_diagonal_helper(Mat, Row, Col, M, N, []).

get_diagonal_helper(Mat, Row, Col, M, N, Acc) ->
    if Row >= 0 and Row < M and Col >= 0 and Col < N ->
        get_diagonal_helper(Mat, Row + 1, Col + 1, M, N, [lists:nth(Col + 1, lists:nth(Row + 1, Mat)) | Acc]);
    true ->
        lists:reverse(Acc)
    end.

put_diagonal(Mat, SortedDiagonal, Row, Col, M, N) ->
    put_diagonal_helper(Mat, SortedDiagonal, Row, Col, M, N, 1).

put_diagonal_helper(Mat, [H | T], Row, Col, M, N, Index) ->
    if Row >= 0 and Row < M and Col >= 0 and Col < N ->
        Mat1 = lists:nth(Row + 1, Mat),
        Mat2 = lists:nth(Col + 1, Mat1),
        NewMat1 = lists:replace(Col + 1, H, Mat1),
        NewMat = lists:replace(Row + 1, NewMat1, Mat),
        put_diagonal_helper(NewMat, T, Row + 1, Col + 1, M, N, Index + 1);
    true ->
        Mat
    end;
put_diagonal_helper(Mat, [], Row, Col, M, N, Index) ->
    Mat.