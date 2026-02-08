-module(solution).
-export([shortestPathLength/1]).

shortestPathLength(Graph) ->
    N = length(Graph),
    TargetMask = (1 bsl N) - 1,

    % Initialize queue and seen set
    % Queue stores { {CurrentNode, VisitedMask}, Distance }
    % Seen stores {CurrentNode, VisitedMask}
    InitialQueue = queue:new(),
    InitialSeen = gb_sets:new(),

    {Queue, Seen} = lists:foldl(
        fun(I, {AccQueue, AccSeen}) ->
            InitialState = {I, (1 bsl I)},
            {queue:in({InitialState, 0}, AccQueue), gb_sets:add(InitialState, AccSeen)}
        end,
        {InitialQueue, InitialSeen},
        lists:seq(0, N - 1)
    ),

    bfs(Queue, Seen, N, TargetMask, Graph).

bfs(Queue, _Seen, _N, TargetMask, _Graph) when queue:is_empty(Queue) ->
    % This case should ideally not be reached if a path always exists (as per problem constraints)
    % For N=0 or N=1, the target mask check would return 0 immediately.
    % If N > 1 and no path, this would indicate an error or unreachable state.
    % For this problem, it implies a path was found and returned earlier.
    0; 

bfs(Queue, Seen, N, TargetMask, Graph) ->
    {{State, Dist}, NewQueue} = queue:out(Queue),
    {U, Mask} = State,

    % Check if all nodes have been visited
    if Mask == TargetMask ->
        Dist;
    true ->
        % Explore neighbors
        % Graph is 0-indexed, but lists:nth is 1-indexed, so we use U + 1
        Neighbors = lists:nth(U + 1, Graph), 

        {NextQueue, NextSeen} = lists:foldl(
            fun(V, {AccQueue, AccSeen}) ->
                NewMask = Mask bor (1 bsl V),
                NewState = {V, NewMask},

                if gb_sets:is_member(NewState, AccSeen) ->
                    {AccQueue, AccSeen};
                true ->
                    {queue:in({NewState, Dist + 1}, AccQueue), gb_sets:add(NewState, AccSeen)}
                end
            end,
            {NewQueue, Seen}, % Start with the queue after dequeuing current state and the current Seen set
            Neighbors
        ),
        bfs(NextQueue, NextSeen, N, TargetMask, Graph)
    end.