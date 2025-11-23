-module(solution).
-export([shortestPath/2]).

shortestPath(Grid, K) ->
    M = length(Grid),
    N = length(hd(Grid)),

    if M == 1 andalso N == 1 ->
        0;
    true ->
        InitialState = {0, 0, K, 0}, % {Row, Col, RemainingK, Steps}

        Queue = queue:in(InitialState, queue:new()),
        Visited = sets:add_element({0, 0, K}, sets:new()), % {Row, Col, RemainingK}

        bfs(Queue, Visited, Grid, M, N)
    end.

bfs(Queue, Visited, Grid, M, N) ->
    case queue:out(Queue) of
        {empty, _} ->
            -1;
        {ok, {R, C, K_rem, Steps}, CurrentQueue} ->
            if R == M - 1 andalso C == N - 1 ->
                Steps;
            true ->
                Neighbors = [{R + 1, C}, {R - 1, C}, {R, C + 1}, {R, C - 1}],

                {UpdatedQueue, UpdatedVisited} = lists:foldl(
                    fun({NR, NC}, {AccQueue, AccVisited}) ->
                        if NR >= 0 andalso NR < M andalso NC >= 0 andalso NC < N ->
                            CellVal = get_cell_value(Grid, NR, NC),
                            NewK_rem = K_rem - CellVal,

                            if NewK_rem >= 0 andalso not sets:is_element({NR, NC, NewK_rem}, AccVisited) ->
                                {queue:in({NR, NC, NewK_rem, Steps + 1}, AccQueue),
                                 sets:add_element({NR, NC, NewK_rem}, AccVisited)};
                            true ->
                                {AccQueue, AccVisited}
                            end;
                        true ->
                            {AccQueue, AccVisited}
                        end
                    end,
                    {CurrentQueue, Visited},
                    Neighbors
                ),
                bfs(UpdatedQueue, UpdatedVisited, Grid, M, N)
            end
    end.

get_cell_value(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).