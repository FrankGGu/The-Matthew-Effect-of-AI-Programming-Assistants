-module(solution).
-export([minimum_time/2]).

minimum_time(Grid, _Start) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {X, Y} = _Start,
    Visited = array:new({1, Rows}, {default, array:new({1, Cols}, {default, -1})}),
    Q = queue:new(),
    queue:in({X, Y, 0}, Q),
    array:set({X + 1, Y + 1}, 0, Visited),
    Dirs = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    min_time(Grid, Rows, Cols, Q, Visited, Dirs).

min_time(_, _, _, Q, Visited, _) when queue:is_empty(Q) ->
    -1;

min_time(Grid, Rows, Cols, Q, Visited, Dirs) ->
    {{X, Y, T}, NewQ} = queue:out(Q),
    case X of
        _ when X < 0; X >= Rows; Y < 0; Y >= Cols -> min_time(Grid, Rows, Cols, NewQ, Visited, Dirs);
        _ ->
            case Grid!!{X + 1}!!{Y + 1} of
                0 ->
                    T;
                _ ->
                    lists:foreach(fun({DX, DY}) ->
                        NX = X + DX,
                        NY = Y + DY,
                        case NX of
                            _ when NX < 0; NX >= Rows; NY < 0; NY >= Cols -> ok;
                            _ ->
                                case array:get({NX + 1, NY + 1}, Visited) of
                                    -1 ->
                                        array:set({NX + 1, NY + 1}, T + 1, Visited),
                                        queue:in({NX, NY, T + 1}, NewQ);
                                    Val when Val > T + 1 ->
                                        array:set({NX + 1, NY + 1}, T + 1, Visited),
                                        queue:in({NX, NY, T + 1}, NewQ);
                                    _ -> ok
                                end
                        end
                    end, Dirs),
                    min_time(Grid, Rows, Cols, NewQ, Visited, Dirs)
            end
    end.