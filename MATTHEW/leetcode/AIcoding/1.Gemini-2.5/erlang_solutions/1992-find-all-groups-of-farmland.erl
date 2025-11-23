-module(solution).
-export([find_farmland/1]).

get_cell_array(GridArrays, R, C) ->
    array:get(C, array:get(R, GridArrays)).

is_valid(R, C, Rows, Cols) ->
    R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols.

find_farmland(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    GridArrays = array:from_list([array:from_list(Row) || Row <- Grid]),

    Visited = gb_sets:empty(),

    find_farmland_iterate(0, 0, Rows, Cols, GridArrays, Visited, []).

find_farmland_iterate(R, C, Rows, Cols, GridArrays, Visited, Acc) when R < Rows ->
    case get_cell_array(GridArrays, R, C) of
        1 ->
            case gb_sets:is_member({R, C}, Visited) of
                true ->
                    next_cell_and_continue(R, C, Rows, Cols, GridArrays, Visited, Acc);
                false ->
                    {BoundingBox, NewVisited} = explore_farmland(GridArrays, R, C, Rows, Cols, Visited),
                    next_cell_and_continue(R, C, Rows, Cols, GridArrays, NewVisited, [BoundingBox | Acc])
            end;
        0 ->
            next_cell_and_continue(R, C, Rows, Cols, GridArrays, Visited, Acc)
    end;
find_farmland_iterate(_R, _C, _Rows, _Cols, _GridArrays, _Visited, Acc) ->
    lists:reverse(Acc).

next_cell_and_continue(R, C, Rows, Cols, GridArrays, Visited, Acc) ->
    NewC = C + 1,
    case NewC >= Cols of
        true ->
            find_farmland_iterate(R + 1, 0, Rows, Cols, GridArrays, Visited, Acc);
        false ->
            find_farmland_iterate(R, NewC, Rows, Cols, GridArrays, Visited, Acc)
    end.

explore_farmland(GridArrays, StartR, StartC, Rows, Cols, InitialVisited) ->
    Queue = queue_add({StartR, StartC}, queue_new()),

    CurrentVisited = gb_sets:add({StartR, StartC}, InitialVisited),

    explore_bfs(GridArrays, Queue, CurrentVisited, StartR, StartC, StartR, StartC, Rows, Cols).

explore_bfs(GridArrays, Queue, CurrentVisited, MinR, MinC, MaxR, MaxC, Rows, Cols) ->
    case queue_get(Queue) of
        {empty, _} ->
            {[MinR, MinC, MaxR, MaxC], CurrentVisited};
        {{CurrR, CurrC}, RestQueue} ->
            NewMinR = min(MinR, CurrR),
            NewMinC = min(MinC, CurrC),
            NewMaxR = max(MaxR, CurrR),
            NewMaxC = max(MaxC, CurrC),

            Directions = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],

            {UpdatedQueue, UpdatedVisited} = lists:foldl(
                fun({DR, DC}, {AccQueue, AccVisited}) ->
                    NR = CurrR + DR,
                    NC = CurrC + DC,
                    case is_valid(NR, NC, Rows, Cols) andalso get_cell_array(GridArrays, NR, NC) == 1 andalso not gb_sets:is_member({NR, NC}, AccVisited) of
                        true ->
                            {queue_add({NR, NC}, AccQueue), gb_sets:add({NR, NC}, AccVisited)};
                        false ->
                            {AccQueue, AccVisited}
                    end
                end,
                {RestQueue, CurrentVisited},
                Directions
            ),

            explore_bfs(GridArrays, UpdatedQueue, UpdatedVisited, NewMinR, NewMinC, NewMaxR, NewMaxC, Rows, Cols)
    end.

queue_new() -> {[], []}.
queue_add(Element, {Front, Back}) -> {Front, [Element | Back]}.
queue_get({[], []}) -> {empty, {[], []}};
queue_get({[X | Xs], Back}) -> {X, {Xs, Back}};
queue_get({[], Back}) ->
    ReversedBack = lists:reverse(Back),
    {X, Xs} = lists:split_at(1, ReversedBack),
    {hd(X), {Xs, []}}.