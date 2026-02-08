-module(solution).
-export([solve/1]).

solve(Grid) ->
    {Rows, Cols} = {length(Grid), length(hd(Grid))},
    {StartR, StartC} = find_char(Grid, 'S'),
    {EndR, EndC} = find_char(Grid, 'E'),
    Teleports = find_all_char(Grid, 'T'),

    Queue = queue:new(),
    Queue1 = queue:in({{StartR, StartC}, 0}, Queue), % { {R, C}, Steps }
    Visited = sets:new(),
    Visited1 = sets:add({StartR, StartC}, Visited),

    bfs_loop(Queue1, Visited1, Grid, Rows, Cols, {EndR, EndC}, Teleports, false).

find_char(Grid, Char) ->
    find_char(Grid, Char, 0).

find_char([RowList | Rest], Char, R) ->
    case lists:member(Char, RowList) of
        true -> {R, lists:find_index(fun(X) -> X == Char end, RowList)};
        false -> find_char(Rest, Char, R + 1)
    end.

find_all_char(Grid, Char) ->
    find_all_char(Grid, Char, 0, []).

find_all_char([], _, _, Acc) -> Acc;
find_all_char([RowList | Rest], Char, R, Acc) ->
    Indices = find_all_indices(RowList, Char, 0),
    Coords = [{R, C} || C <- Indices],
    find_all_char(Rest, Char, R + 1, Acc ++ Coords).

find_all_indices([], _, _) -> [];
find_all_indices([H | T], Char, Idx) when H == Char -> [Idx | find_all_indices(T, Char, Idx + 1)];
find_all_indices([_ | T], Char, Idx) -> find_all_indices(T, Char, Idx + 1).

bfs_loop(Queue, Visited, Grid, Rows, Cols, End, Teleports, TeleportActivatedGlobally) ->
    case queue:is_empty(Queue) of
        true -> -1;
        false ->
            {{Value, Queue2}, _} = queue:out(Queue),
            {{R, C}, Steps} = Value,

            if {R, C} == End -> Steps;
            else
                % Explore 4 directions
                Neighbors = [{R+DR, C+DC} || {DR, DC} <- [{0,1},{0,-1},{1,0},{-1,0}]],

                {NextQueue, NextVisited} = 
                    lists:foldl(fun(Neighbor, {Q_acc, V_acc}) ->
                        explore_neighbor(Neighbor, Steps + 1, Q_acc, V_acc, Grid, Rows, Cols)
                    end, {Queue2, Visited}, Neighbors),

                CurrentChar = get_char(Grid, R, C),
                if CurrentChar == 'T' and not TeleportActivatedGlobally ->
                    % Activate teleportation: add neighbors of ALL teleport points
                    {TeleportQueue, TeleportVisited} = 
                        lists:foldl(fun(TeleportCoord, {Q_acc, V_acc}) ->
                            {TR, TC} = TeleportCoord,
                            TeleportNeighbors = [{TR+DR, TC+DC} || {DR, DC} <- [{0,1},{0,-1},{1,0},{-1,0}]],
                            lists:foldl(fun(TN, {Q_inner, V_inner}) ->
                                explore_neighbor(TN, Steps + 1, Q_inner, V_inner, Grid, Rows, Cols)
                            end, {Q_acc, V_acc}, TeleportNeighbors)
                        end, {NextQueue, NextVisited}, Teleports),

                    bfs_loop(TeleportQueue, TeleportVisited, Grid, Rows, Cols, End, Teleports, true);
                else
                    bfs_loop(NextQueue, NextVisited, Grid, Rows, Cols, End, Teleports, TeleportActivatedGlobally)
                end
            end
    end.

explore_neighbor({NR, NC}, NewSteps, Queue, Visited, Grid, Rows, Cols) ->
    if NR >= 0 and NR < Rows and NC >= 0 and NC < Cols ->
        Char = get_char(Grid, NR, NC),
        if Char == '#' ->
            {Queue, Visited};
        else
            if not sets:is_element({NR, NC}, Visited) ->
                NewVisited = sets:add({NR, NC}, Visited),
                NewQueue = queue:in({{NR, NC}, NewSteps}, Queue),
                {NewQueue, NewVisited};
            else
                {Queue, Visited}
            end
        end;
    else
        {Queue, Visited}
    end.

get_char(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).