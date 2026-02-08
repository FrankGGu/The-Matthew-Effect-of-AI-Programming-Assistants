-module(solution).
-export([max_distance/1]).

max_distance(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> -1;
        true ->
            Cols = length(hd(Grid)),
            Q = queue:new(),
            I = 0,
            J = 0,
            init_queue(Grid, Rows, Cols, Q, I, J),
            MaxDist = -1,
            BFS(Grid, Rows, Cols, Q, MaxDist)
    end.

init_queue(_, _, _, Q, _, Cols) when Cols == 0 -> Q;
init_queue(Grid, Rows, Cols, Q, I, J) ->
    case J of
        Cols -> init_queue(Grid, Rows, Cols, Q, I+1, 0);
        _ ->
            case lists:nth(I+1, Grid) of
                Row ->
                    case lists:nth(J+1, Row) of
                        0 -> init_queue(Grid, Rows, Cols, Q, I, J+1);
                        _ -> init_queue(Grid, Rows, Cols, queue:in({I, J}, Q), I, J+1)
                    end
            end
    end.

BFS(_, _, _, Q, MaxDist) when queue:is_empty(Q) -> MaxDist;
BFS(Grid, Rows, Cols, Q, MaxDist) ->
    {value, {I, J}, NewQ} = queue:out(Q),
    Directions = [{-1,0}, {1,0}, {0,-1}, {0,1}],
    NewMaxDist = max(MaxDist, get_distance(Grid, I, J)),
    lists:foreach(fun({DI, DJ}) ->
        NI = I + DI,
        NJ = J + DJ,
        if
            NI >= 0, NI < Rows, NJ >= 0, NJ < Cols, lists:nth(NI+1, Grid) -- [lists:nth(NJ+1, lists:nth(NI+1, Grid))] == 0 ->
                lists:put(NI+1, lists:put(NJ+1, 1, lists:nth(NI+1, Grid)), Grid),
                BFS(Grid, Rows, Cols, queue:in({NI, NJ}, NewQ), NewMaxDist);
            true -> ok
        end
    end, Directions),
    BFS(Grid, Rows, Cols, NewQ, NewMaxDist).

get_distance(_, I, J) ->
    case I of
        0 -> J;
        _ -> I
    end.