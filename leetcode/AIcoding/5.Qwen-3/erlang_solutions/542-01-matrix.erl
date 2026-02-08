-module(matrix).
-export([updateMatrix/1]).

updateMatrix(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> [];
        true ->
            Cols = length(hd(Matrix)),
            Q = queue:new(),
            I = lists:seq(0, Rows - 1),
            J = lists:seq(0, Cols - 1),
            lists:foreach(fun(Ii) ->
                lists:foreach(fun(Jj) ->
                    case Matrix!!Ii!!Jj of
                        0 -> queue:in({Ii, Jj}, Q);
                        _ -> ok
                    end
                end, J)
            end, I),
            Directions = [{-1,0},{1,0},{0,-1},{0,1}],
            Dist = matrix_init(Rows, Cols),
            update(Dist, Q, Matrix, Directions, Rows, Cols)
    end.

matrix_init(Rows, Cols) ->
    lists:map(fun(_) -> lists:seq(0, Cols - 1) end, lists:seq(0, Rows - 1)).

update(Dist, Q, Matrix, Directions, Rows, Cols) ->
    case queue:out(Q) of
        {empty, _} -> Dist;
        {{value, {I, J}}, NewQ} ->
            lists:foreach(fun({Di, Dj}) ->
                Ni = I + Di,
                Nj = J + Dj,
                if
                    Ni >= 0, Ni < Rows, Nj >= 0, Nj < Cols ->
                        case Dist!!Ni!!Nj of
                            0 -> ok;
                            _ ->
                                Dist2 = Dist,
                                Dist2!!Ni!!Nj = Dist!!I!!J + 1,
                                queue:in({Ni, Nj}, NewQ)
                        end;
                    true -> ok
                end
            end, Directions),
            update(Dist, NewQ, Matrix, Directions, Rows, Cols)
    end.