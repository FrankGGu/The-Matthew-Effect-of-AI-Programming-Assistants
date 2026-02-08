-spec update_matrix(Matrix :: [[integer()]]) -> [[integer()]].
update_matrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Queue = lists:flatten([ [{I, J}, 0] || I <- lists:seq(0, Rows-1), J <- lists:seq(0, Cols-1), lists:nth(J+1, lists:nth(I+1, Matrix)) =:= 0 ]),
    Visited = sets:from_list([ {I, J} || {I, J, _} <- Queue ]),
    bfs(Queue, Visited, Matrix, Rows, Cols).

bfs([], _, Matrix, _, _) -> Matrix;
bfs([{{I, J}, Dist} | Rest], Visited, Matrix, Rows, Cols) ->
    NewMatrix = set_matrix_value(Matrix, I, J, Dist),
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    NewQueue = lists:foldl(fun({Di, Dj}, Acc) ->
        Ni = I + Di,
        Nj = J + Dj,
        case Ni >= 0 andalso Ni < Rows andalso Nj >= 0 andalso Nj < Cols andalso not sets:is_element({Ni, Nj}, Visited) of
            true ->
                sets:add_element({Ni, Nj}, Visited),
                Acc ++ [{{Ni, Nj}, Dist + 1}];
            false ->
                Acc
        end
    end, Rest, Directions),
    bfs(NewQueue, Visited, NewMatrix, Rows, Cols).

set_matrix_value(Matrix, I, J, Value) ->
    Row = lists:nth(I+1, Matrix),
    NewRow = setnth(J+1, Row, Value),
    setnth(I+1, Matrix, NewRow).

setnth(1, [_ | T], X) -> [X | T];
setnth(N, [H | T], X) -> [H | setnth(N-1, T, X)].