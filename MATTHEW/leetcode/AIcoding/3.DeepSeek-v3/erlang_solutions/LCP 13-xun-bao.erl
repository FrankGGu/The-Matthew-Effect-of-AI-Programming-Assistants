-module(solution).
-export([minimal_steps/1]).

minimal_steps(Maze) ->
    {Start, Stones, Targets} = parse_maze(Maze),
    case Targets of
        [] -> 0;
        _ ->
            StonesList = maps:to_list(Stones),
            TargetsList = maps:to_list(Targets),
            {MinSteps, _} = find_min_steps(Start, StonesList, TargetsList, #{}),
            MinSteps
    end.

parse_maze(Maze) ->
    parse_maze(Maze, 0, 0, #{}, #{}, undefined).

parse_maze([], _, _, Stones, Targets, Start) -> {Start, Stones, Targets};
parse_maze([Row | Rest], X, Y, Stones, Targets, Start) ->
    {NewStones, NewTargets, NewStart} = parse_row(Row, X, Y, Stones, Targets, Start),
    parse_maze(Rest, X, Y + 1, NewStones, NewTargets, NewStart).

parse_row([], _, _, Stones, Targets, Start) -> {Stones, Targets, Start};
parse_row([$S | Rest], X, Y, Stones, Targets, _) ->
    parse_row(Rest, X + 1, Y, Stones, Targets, {X, Y});
parse_row([$M | Rest], X, Y, Stones, Targets, Start) ->
    parse_row(Rest, X + 1, Y, Stones, Targets#{ {X, Y} => true }, Start);
parse_row([$O | Rest], X, Y, Stones, Targets, Start) ->
    parse_row(Rest, X + 1, Y, Stones#{ {X, Y} => true }, Targets, Start);
parse_row([_ | Rest], X, Y, Stones, Targets, Start) ->
    parse_row(Rest, X + 1, Y, Stones, Targets, Start).

find_min_steps(Start, Stones, Targets, Memo) ->
    case Targets of
        [] -> {0, Memo};
        _ ->
            case maps:get({Start, Targets}, Memo, undefined) of
                undefined ->
                    {MinSteps, NewMemo} = calculate_min_steps(Start, Stones, Targets, Memo),
                    {MinSteps, NewMemo#{ {Start, Targets} => MinSteps }};
                Cached -> {Cached, Memo}
            end
    end.

calculate_min_steps(Start, Stones, Targets, Memo) ->
    lists:foldl(fun({TargetPos, _}, {Min, AccMemo}) ->
        {Steps1, Memo1} = find_path(Start, TargetPos, Stones, AccMemo),
        {Steps2, Memo2} = find_min_steps(TargetPos, Stones, lists:keydelete(TargetPos, 1, Targets), Memo1),
        Total = Steps1 + Steps2,
        if
            Total < Min -> {Total, Memo2};
            true -> {Min, Memo2}
        end
    end, {infinity, Memo}, Targets).

find_path(Start, Target, Stones, Memo) ->
    case maps:get({Start, Target}, Memo, undefined) of
        undefined ->
            Steps = bfs(Start, Target, Stones),
            {Steps, Memo#{ {Start, Target} => Steps }};
        Cached -> {Cached, Memo}
    end.

bfs(Start, Target, Stones) ->
    Visited = sets:new(),
    Queue = queue:in({Start, 0}, queue:new()),
    bfs_loop(Queue, Visited, Target, Stones).

bfs_loop(Queue, Visited, Target, Stones) ->
    case queue:out(Queue) of
        {empty, _} -> infinity;
        {{value, {{X, Y}, Steps}}, NewQueue} ->
            case {X, Y} of
                Target -> Steps;
                _ ->
                    case sets:is_element({X, Y}, Visited) of
                        true -> bfs_loop(NewQueue, Visited, Target, Stones);
                        false ->
                            NewVisited = sets:add_element({X, Y}, Visited),
                            Neighbors = get_neighbors({X, Y}, Stones),
                            UpdatedQueue = lists:foldl(fun(Pos, Q) ->
                                queue:in({Pos, Steps + 1}, Q)
                            end, NewQueue, Neighbors),
                            bfs_loop(UpdatedQueue, NewVisited, Target, Stones)
                    end
            end
    end.

get_neighbors({X, Y}, Stones) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:filtermap(fun({Dx, Dy}) ->
        NewX = X + Dx,
        NewY = Y + Dy,
        case maps:is_key({NewX, NewY}, Stones) of
            true -> {true, {NewX, NewY}};
            false -> false
        end
    end, Directions).