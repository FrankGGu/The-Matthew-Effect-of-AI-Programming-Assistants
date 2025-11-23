-spec matrix_reshape(Mat :: [[integer()]], R :: integer(), C :: integer()) -> [[integer()]].
matrix_reshape(Mat, R, C) ->
    M = length(Mat),
    case M of
        0 -> Mat;
        _ ->
            N = length(hd(Mat)),
            case M * N =:= R * C of
                true ->
                    Flattened = lists:append(Mat),
                    reshape(Flattened, R, C, []);
                false ->
                    Mat
            end
    end.

reshape(_, 0, _, Acc) ->
    lists:reverse(Acc);
reshape(Flattened, R, C, Acc) ->
    {Row, Rest} = lists:split(C, Flattened),
    reshape(Rest, R - 1, C, [Row | Acc]).