-module(solution).
-export([update_matrix/2]).

update_matrix(Matrix, Updates) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Acc = lists:seq(1, Rows, 1),
    Acc1 = lists:map(fun(_) -> lists:seq(1, Cols, 1) end, Acc),
    update_matrix_helper(Matrix, Updates, Acc1).

update_matrix_helper(_, [], Acc) ->
    Acc;
update_matrix_helper(Matrix, [{{R1, C1}, {R2, C2}} | T], Acc) ->
    NewAcc = update_submatrix(Acc, R1, C1, R2, C2),
    update_matrix_helper(Matrix, T, NewAcc).

update_submatrix(Acc, R1, C1, R2, C2) ->
    lists:map(
        fun(R) ->
            if
                R >= R1, R =< R2 ->
                    lists:map(
                        fun(C) ->
                            if
                                C >= C1, C =< C2 ->
                                    Acc !! (R-1) !! (C-1) + 1;
                                true ->
                                    Acc !! (R-1) !! (C-1)
                            end
                        end,
                        lists:seq(1, length(hd(Acc)), 1)
                    );
                true ->
                    Acc !! (R-1)
            end
        end,
        lists:seq(1, length(Acc), 1)
    ).