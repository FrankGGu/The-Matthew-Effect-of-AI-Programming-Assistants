-module(rotting_oranges).
-export([oranges_rotting/1]).

oranges_rotting(Grid) ->
    oranges_rotting(Grid, 0, []).

oranges_rotting(Grid, Time, Q) ->
    {NewGrid, NewQ} = rot(Grid, Q),
    Fresh = find_fresh(NewGrid),
    case Fresh of
        [] ->
            case NewQ of
                [] -> Time;
                _ -> oranges_rotting(NewGrid, Time + 1, NewQ)
            end;
        _ ->
            case NewQ of
                [] -> -1;
                _ -> oranges_rotting(NewGrid, Time + 1, NewQ)
            end
    end.

rot(Grid, Q) ->
    rot(Grid, Q, [], []).

rot(Grid, [], NewGrid, NewQ) ->
    {NewGrid, NewQ};
rot(Grid, [{R, C} | Rest], NewGrid, NewQ) ->
    Neighbors = get_neighbors(R, C, Grid),
    {UpdatedGrid, UpdatedQ} = update_grid(Grid, R, C, Neighbors, NewGrid, NewQ),
    rot(Grid, Rest, UpdatedGrid, UpdatedQ).

update_grid(Grid, R, C, Neighbors, NewGrid, NewQ) ->
    update_grid(Grid, R, C, Neighbors, NewGrid, NewQ, []).

update_grid(Grid, R, C, [], NewGrid, NewQ, Acc) ->
    case Acc of
        [] -> {Grid, NewQ};
        _ ->
            NewGrid1 = lists:foldl(fun({R1, C1}, G) -> set_element(R1, set_element(C1, G, 2), G) end, Grid, Acc),
            {NewGrid1, NewQ ++ Acc}
    end;

update_grid(Grid, R, C, [{NR, NC} | Rest], NewGrid, NewQ, Acc) ->
    case get_element(NR, NC, Grid) of
        1 ->
            update_grid(Grid, R, C, Rest, NewGrid, NewQ, [{NR, NC} | Acc]);
        _ ->
            update_grid(Grid, R, C, Rest, NewGrid, NewQ, Acc)
    end.

get_neighbors(R, C, Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Neighbors = [],
    Neighbors1 = if R > 1 then [{R - 1, C}] else [],
    Neighbors2 = if R < Rows then [{R + 1, C}] else [],
    Neighbors3 = if C > 1 then [{R, C - 1}] else [],
    Neighbors4 = if C < Cols then [{R, C + 1}] else [],
    Neighbors ++ Neighbors1 ++ Neighbors2 ++ Neighbors3 ++ Neighbors4.

find_fresh(Grid) ->
    find_fresh(Grid, 1, 1, []).

find_fresh(Grid, R, C, Acc) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    case {R > Rows, C > Cols} of
        {true, _} -> Acc;
        {_, true} -> find_fresh(Grid, R + 1, 1, Acc);
        {false, false} ->
            case get_element(R, C, Grid) of
                1 -> find_fresh(Grid, R, C + 1, [{R, C} | Acc]);
                _ -> find_fresh(Grid, R, C + 1, Acc)
            end
    end.

get_element(R, C, Grid) ->
    lists:nth(C, lists:nth(R, Grid)).

set_element(R, C, Val, Grid) ->
    lists:nth(R, lists:map(fun(Row, I) -> if I == R then set_element_row(C, Val, Row) else Row end, Grid, lists:seq(1, length(Grid)))) .

set_element_row(C, Val, Row) ->
    lists:map(fun(Elem, I) -> if I == C then Val else Elem end, Row, lists:seq(1, length(Row))).