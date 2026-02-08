-module(snake_in_matrix).
-export([snake_matrix/1]).

snake_matrix(N) when N > 0 ->
    Matrix = lists:duplicate(N, lists:duplicate(N, 0)),
    fill_matrix(Matrix, 1, {0, 0}, {0, 1}, N).

fill_matrix(Matrix, Current, {Row, Col}, {Dr, Dc}, N) ->
    case Current > N * N of
        true -> Matrix;
        false ->
            NewRow = Row + Dr,
            NewCol = Col + Dc,
            NewMatrix = lists:substitute(Matrix, Current, {Row, Col}),
            case (NewRow >= N orelse NewRow < 0 orelse NewCol >= N orelse NewCol < 0 orelse lists:nth(NewRow + 1, NewMatrix) =/= lists:duplicate(N, 0)) of
                true -> fill_matrix(NewMatrix, Current, {Row, Col}, {0, 1}, N);
                false -> fill_matrix(NewMatrix, Current + 1, {NewRow, NewCol}, {Dr, Dc}, N)
            end
    end.

substitute(Matrix, Value, {Row, Col}) ->
    lists:map(fun (R, I) -> if I =:= Row -> lists:replace(R, Col + 1, Value); true -> R end end, Matrix).