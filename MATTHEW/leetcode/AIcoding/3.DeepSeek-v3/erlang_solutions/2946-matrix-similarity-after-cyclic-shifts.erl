-spec are_similar(Mat :: [[integer()]], K :: integer()) -> boolean().
are_similar(Mat, K) ->
    M = length(Mat),
    N = length(hd(Mat)),
    case K rem N of
        0 -> true;
        _ ->
            lists:all(fun(Row) ->
                Shifted = rotate_row(Row, K),
                lists:zipwith(fun(X, Y) -> X == Y end, Row, Shifted)
            end, Mat)
    end.

rotate_row(Row, K) ->
    N = length(Row),
    Shift = K rem N,
    case Shift >= 0 of
        true ->
            {Left, Right} = lists:split(N - Shift, Row),
            Right ++ Left;
        false ->
            {Left, Right} = lists:split(-Shift, Row),
            Right ++ Left
    end.