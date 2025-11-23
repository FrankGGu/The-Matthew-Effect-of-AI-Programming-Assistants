-spec check_x_matrix(Matrix :: [[integer()]]) -> boolean().
check_x_matrix(Matrix) ->
    N = length(Matrix),
    lists:all(fun(I) ->
        lists:all(fun(J) ->
            case (I =:= J) orelse (I + J =:= N - 1) of
                true -> lists:nth(J + 1, lists:nth(I + 1, Matrix)) =/= 0;
                false -> lists:nth(J + 1, lists:nth(I + 1, Matrix)) =:= 0
            end
        end, lists:seq(0, N - 1))
    end, lists:seq(0, N - 1)).