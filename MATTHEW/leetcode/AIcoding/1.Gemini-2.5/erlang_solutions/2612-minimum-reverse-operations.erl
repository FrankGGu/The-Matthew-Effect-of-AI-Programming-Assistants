-module(solution).
-export([solve/3]).

solve(N, P, K) ->
    % Initialize the answer array with -1 (unreachable)
    Ans = array:new([{size, N}, {fixed, true}, {default, -1}]),
    % Initialize the BFS queue
    Q = queue:new(),

    % Initialize two gb_trees to store unvisited nodes, separated by parity
    UnvisitedEven = gb_trees:empty(),
    UnvisitedOdd = gb_trees:empty(),

    % Populate unvisited sets
    UnvisitedEven0 = lists:foldl(fun(I, Acc) -> gb_trees:insert(I, I, Acc) end, UnvisitedEven, [I || I <- lists:seq(0, N-1), I rem 2 == 0]),
    UnvisitedOdd0 = lists:foldl(fun(I, Acc) -> gb_trees:insert(I, I, Acc) end, UnvisitedOdd, [I || I <- lists:seq(0, N-1), I rem 2 == 1]),

    % Start BFS from initial position P
    Q1 = queue:in(P, Q),
    Ans1 = array:set(P, 0, Ans), % Distance to P is 0

    % Remove P from its respective unvisited set
    {UnvisitedEven1, UnvisitedOdd1} =
        case P rem 2 of
            0 -> {gb_trees:delete(P, UnvisitedEven0), UnvisitedOdd0};
            1 -> {UnvisitedEven0, gb_trees:delete(P, UnvisitedOdd0)}
        end,

    % Call the BFS helper function
    bfs(Q1, Ans1, UnvisitedEven1, UnvisitedOdd1, N, K).

bfs(Q, Ans, UnvisitedEven, UnvisitedOdd, N, K) ->
    case queue:out(Q) of
        {{value, Curr}, NewQ} ->
            Dist = array:get(Curr, Ans),

            % Calculate the range of 'j' for reverse operations
            % where 'Curr' is within [j, j+K-1]
            MinJ = max(0, Curr - K + 1),
            MaxJ = min(Curr, N - K),

            % Calculate the range [S, E] of reachable positions from 'Curr'
            % These positions are 2*j + K - 1 - Curr
            S = 2 * MinJ + K - 1 - Curr,
            E = 2 * MaxJ + K - 1 - Curr,

            % Determine which unvisited set to use based on S's parity
            % All reachable positions from Curr will have the same parity as S
            {TargetUnvisited, OtherUnvisited, TargetParity} =
                case S rem 2 of
                    0 -> {UnvisitedEven, UnvisitedOdd, 0};
                    1 -> {UnvisitedOdd, UnvisitedEven, 1}
                end,

            % Iterate and process unvisited nodes in the range [S, E] with the correct parity
            {UpdatedQ, UpdatedAns, NewTargetUnvisited} =
                process_range(S, E, Dist + 1, TargetUnvisited, NewQ, Ans),

            % Continue BFS with updated state
            bfs(UpdatedQ, UpdatedAns,
                case TargetParity of 0 -> NewTargetUnvisited; 1 -> OtherUnvisited end,
                case TargetParity of 0 -> OtherUnvisited; 1 -> NewTargetUnvisited end,
                N, K);
        {empty, _} ->
            % BFS queue is empty, all reachable nodes processed
            array:to_list(Ans)
    end.

process_range(StartRange, EndRange, NewDist, UnvisitedTree, Q, Ans) ->
    Loop = fun Loop(Node, AccQ, AccAns, AccUnvisited) ->
        case gb_trees:larger(Node, AccUnvisited) of % Find smallest element >= Node
            {NextNode, _} when NextNode =< EndRange ->
                % NextNode is an unvisited node in the range [StartRange, EndRange]
                NewAccAns = array:set(NextNode, NewDist, AccAns),
                NewAccQ = queue:in(NextNode, AccQ),
                NewAccUnvisited = gb_trees:delete(NextNode, AccUnvisited),
                % Recursively call Loop to find the next node with the same parity
                Loop(NextNode + 2, NewAccQ, NewAccAns, NewAccUnvisited);
            _ ->
                % No more nodes in the range or no more unvisited nodes
                {AccQ, AccAns, AccUnvisited}
        end
    end,
    Loop(StartRange, Q, Ans, UnvisitedTree).