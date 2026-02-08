-spec is_toeplitz_matrix(Matrix :: [[integer()]]) -> boolean().
is_toeplitz_matrix(Matrix) ->
    Rows = length(Matrix),
    case Rows of
        0 -> true;
        _ ->
            Cols = length(hd(Matrix)),
            lists:all(fun({I, J}) ->
                Val = lists:nth(J, lists:nth(I, Matrix)),
                Check = fun(X, Y) ->
                    if
                        X > Rows -> true;
                        Y > Cols -> true;
                        true ->
                            lists:nth(Y, lists:nth(X, Matrix)) =:= Val
                    end
                end,
                Check(I + 1, J + 1)
            end, [{I, J} || I <- lists:seq(1, Rows - 1), J <- lists:seq(1, Cols - 1)])
    end.