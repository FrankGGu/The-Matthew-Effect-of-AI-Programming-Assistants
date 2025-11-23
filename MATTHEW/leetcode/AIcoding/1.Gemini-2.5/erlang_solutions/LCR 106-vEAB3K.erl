-module(solution).
-export([is_bipartite/1]).

is_bipartite(Graph) ->
    N = length(Graph),
    Colors = array:new(N, {uncolored}),
    GraphArray = array:from_list(Graph), % Convert Graph to an array for O(1) access
    is_bipartite_loop(0, N, GraphArray, Colors).

is_bipartite_loop(Node, N, _GraphArray, _Colors) when Node == N ->
    true;
is_bipartite_loop(Node, N, GraphArray, Colors) when Node < N ->
    case array:get(Node, Colors) of
        {uncolored} ->
            % Start BFS from this uncolored node
            % Assign it color 1
            InitialColorsForBFS = array:set(Node, {color, 1}, Colors),
            case bfs(Node, GraphArray, InitialColorsForBFS) of
                {false, _} -> false; % Conflict found in this component
                {true, NewColors} -> is_bipartite_loop(Node + 1, N, GraphArray, NewColors)
            end;
        _ ->
            % Node already colored (part of a previously visited component)
            is_bipartite_loop(Node + 1, N, GraphArray, Colors)
    end.

bfs(StartNode, GraphArray, InitialColors) ->
    Queue = queue:in(StartNode, queue:new()),
    bfs_loop(Queue, GraphArray, InitialColors).

bfs_loop(Queue, GraphArray, Colors) ->
    case queue:out(Queue) of
        {{value, U}, RestQueue} ->
            CurrentUColor = array:get(U, Colors),
            Neighbors = array:get(U, GraphArray), % O(1) access

            NextColor = case CurrentUColor of
                            {color, 1} -> {color, 2};
                            {color, 2} -> {color, 1}
                        end,

            % Process neighbors of U
            {Result, NewQueue, NewColors} = lists:foldl(
                fun(V, {AccResult, AccQueue, AccColors}) ->
                    case AccResult of
                        false -> {false, AccQueue, AccColors}; % Propagate conflict
                        true ->
                            case array:get(V, AccColors) of
                                {uncolored} ->
                                    % V is uncolored, assign opposite color of U and enqueue
                                    {true, queue:in(V, AccQueue), array:set(V, NextColor, AccColors)};
                                CurrentVColor when CurrentVColor == CurrentUColor ->
                                    % V has the same color as U, conflict!
                                    {false, AccQueue, AccColors};
                                _ ->
                                    % V is colored and has a different color than U, no conflict
                                    {true, AccQueue, AccColors}
                            end
                    end
                end,
                {true, RestQueue, Colors},
                Neighbors
            ),

            case Result of
                false -> {false, NewColors}; % Conflict found, return false
                true -> bfs_loop(NewQueue, GraphArray, NewColors) % Continue BFS
            end;
        {empty, _} ->
            {true, Colors} % BFS for this component finished without conflicts
    end.