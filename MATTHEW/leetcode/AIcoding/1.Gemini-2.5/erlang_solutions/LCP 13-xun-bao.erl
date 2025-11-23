-module(solution).
-export([min_steps/1]).

min_steps(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    {StartX, StartY} = find_char(Grid, $S, Rows, Cols),
    {TargetX, TargetY} = find_char(Grid, $T, Rows, Cols),

    Queue = queue:new(),
    Queue1 = queue:in({StartX, StartY, 0}, Queue),

    Visited = sets:new(),
    Visited1 = sets:add({StartX, StartY}, Visited),

    bfs(Queue1, Visited1, Grid, Rows, Cols, TargetX, TargetY).

bfs(Queue, Visited, Grid, Rows, Cols, TargetX, TargetY) ->
    case queue:out(Queue) of
        {{value, {X, Y, Steps}}, RestQueue} ->
            if X == TargetX andalso Y == TargetY ->
                Steps;
            true ->
                Neighbors = get_neighbors(X, Y, Grid, Rows, Cols),

                {UpdatedQueue, UpdatedVisited} = lists:foldl(
                    fun({NX, NY}, {AccQueue, AccVisited}) ->
                        if not sets:is_element({NX, NY}, AccVisited) ->
                            {queue:in({NX, NY, Steps + 1}, AccQueue), sets:add({NX, NY}, AccVisited)};
                        true ->
                            {AccQueue, AccVisited}
                        end
                    end,
                    {RestQueue, Visited},
                    Neighbors
                ),
                bfs(UpdatedQueue, UpdatedVisited, Grid, Rows, Cols, TargetX, TargetY)
            end;
        {empty, _} ->
            -1
    end.

get_neighbors(X, Y, Grid, Rows, Cols) ->
    PossibleMoves = [{X+1, Y}, {X-1, Y}, {X, Y+1}, {X, Y-1}],
    lists:filter(
        fun({NX, NY}) ->
            NX >= 0 andalso NX < Rows andalso
            NY >= 0 andalso NY < Cols andalso
            get_char_at(Grid, NX, NY) =/= $#
        end,
        PossibleMoves
    ).

get_char_at(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

find_char(Grid, Char, Rows, Cols) ->
    find_char(Grid, Char, 0, 0, Rows, Cols).

find_char(Grid, Char, R, C, Rows, Cols) ->
    if R >= Rows ->
        error(char_not_found);
    C >= Cols ->
        find_char(Grid, Char, R + 1, 0, Rows, Cols);
    get_char_at(Grid, R, C) == Char ->
        {R, C};
    true ->
        find_char(Grid, Char, R, C + 1, Rows, Cols)
    end.