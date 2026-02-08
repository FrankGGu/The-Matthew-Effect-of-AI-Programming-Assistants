-module(solution).
-export([min_cost/1]).

min_cost(Grid) ->
    {Rows, Cols} = grid_size(Grid),
    Start = {0, 0},
    End = {Rows - 1, Cols - 1},
    Costs = lists:duplicate(Rows, lists:duplicate(Cols, infinity)),
    Costs1 = lists:foldl(fun(_, Acc) -> lists:map(fun(Row) -> lists:map(fun(_) -> infinity end, Row) end, Acc) end, Costs, lists:seq(0, Rows - 1)),
    Costs2 = lists:update_element(1, lists:update_element(1, Costs1, 0), 1),
    bfs([{0, 0, 0}], Costs2, Grid).

bfs([], Costs, _) ->
    lists:hd(lists:last(Costs));
bfs([{X, Y, Cost} | Rest], Costs, Grid) ->
    if
        {X, Y} = {length(Grid) - 1, length(lists:hd(Grid)) - 1} ->
            Cost;
        true ->
            Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
            NewCosts = lists:foldl(fun({DX, DY}, Acc) ->
                NX = X + DX,
                NY = Y + DY,
                if
                    NX < 0; NY < 0; NX >= length(Grid); NY >= length(lists:hd(Grid)) -> Acc;
                    true ->
                        NewCost = Cost + if lists:nth(NY + 1, lists:nth(NX + 1, Grid)) =:= 1 -> 0; true -> 1 end,
                        if NewCost < lists:nth(NY + 1, lists:nth(NX + 1, Acc)) ->
                            Acc1 = lists:update_element(NY + 1, lists:update_element(NX + 1, Acc, NewCost), NY + 1),
                            [{NX, NY, NewCost} | Acc1];
                        true -> Acc
                        end
                end
            end, Rest, Costs),
            bfs(NewCosts, Costs, Grid)
    end.

grid_size(Grid) ->
    {length(Grid), length(lists:hd(Grid))}.