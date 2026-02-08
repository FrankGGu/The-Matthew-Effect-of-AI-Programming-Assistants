-module(solution).
-export([cut_wood/1]).

cut_wood(Forest) ->
    Rows = length(Forest),
    Cols = length(hd(Forest)),
    Trees = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun({Val, Col}, Acc2) ->
            if Val > 0 -> [{Val, R, Col} | Acc2]; true -> Acc2 end
        end, Acc, lists:zip(lists:seq(0, Cols-1), Row))
    end, [], lists:zip(lists:seq(0, Rows-1), Forest)),
    SortedTrees = lists:sort(Trees),
    Start = {0, 0},
    TotalSteps = lists:foldl(fun({Height, R, C}, Acc) ->
        Steps = bfs(Forest, Start, {R, C}),
        case Steps of
            -1 -> -1;
            _ -> Acc + Steps
        end
    end, 0, SortedTrees),
    if TotalSteps == -1 -> -1; true -> TotalSteps end.

bfs(Forest, Start, Target) ->
    Rows = length(Forest),
    Cols = length(hd(Forest)),
    Visited = gb_sets:empty(),
    Queue = queue:from_list([{Start, 0}]),
    bfs_loop(Forest, Target, Visited, Queue).

bfs_loop(Forest, Target, Visited, Queue) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{Value, Steps}, NewQueue} ->
            {R, C} = Value,
            if Value == Target -> Steps;
               true ->
                   Neighbors = get_neighbors(R, C, Rows, Cols),
                   NewVisited = gb_sets:add(Value, Visited),
                   NewQueue2 = lists:foldl(fun({NR, NC}, Q) ->
                        if gb_sets:is_member({NR, NC}, NewVisited) -> Q;
                           true ->
                               case lists:nth(NR+1, Forest) of
                                   Row when is_list(Row) ->
                                       Val = lists:nth(NC+1, Row),
                                       if Val > 0 -> queue:in({{NR, NC}, Steps+1}, Q);
                                          true -> Q
                                       end;
                                   _ -> Q
                               end
                        end
                    end, NewQueue, Neighbors),
                   bfs_loop(Forest, Target, NewVisited, NewQueue2)
            end
    end.

get_neighbors(R, C, Rows, Cols) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:filter(fun({DR, DC}) ->
        NR = R + DR,
        NC = C + DC,
        NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols
    end, Directions).