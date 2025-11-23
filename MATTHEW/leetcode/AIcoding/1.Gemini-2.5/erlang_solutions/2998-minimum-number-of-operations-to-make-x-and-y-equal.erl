-module(solution).
-export([minOperations/2]).

minOperations(X, Y) ->
    if X == Y -> 0;
    else
        % Priority Queue: {Steps, CurrentNum}
        % Using gb_trees for a min-priority queue (sorted by Steps)
        PQ = gb_trees:insert({0, X}, gb_trees:empty()),

        % Distance map: CurrentNum -> MinStepsFromX
        % Stores the minimum steps to reach CurrentNum from X
        Dist = #{X => 0},

        % Initialize minimum total steps from X to Y with the direct +1/-1 path
        MinTotalSteps = abs(X - Y),

        dijkstra(PQ, Dist, Y, MinTotalSteps)
    end.

dijkstra(PQ, Dist, Y, MinTotalSteps) ->
    case gb_trees:is_empty(PQ) of
        true ->
            MinTotalSteps;
        false ->
            {{Steps, CurrentNum}, PQ1} = gb_trees:take_smallest(PQ),

            % If we've found a shorter path to CurrentNum already, skip
            % This check is crucial for Dijkstra's correctness
            case maps:get(CurrentNum, Dist, infinity()) of
                ExistingSteps when ExistingSteps < Steps ->
                    dijkstra(PQ1, Dist, Y, MinTotalSteps);
                _ ->
                    % Update the overall minimum steps to Y if a direct path from CurrentNum to Y is better
                    NewMinTotalSteps = min(MinTotalSteps, Steps + abs(CurrentNum - Y)),

                    Neighbors = [],

                    % Operation: CurrentNum / 11 (if divisible)
                    if CurrentNum rem 11 == 0 ->
                        Neighbors1 = [{CurrentNum div 11, Steps + 1} | Neighbors];
                    true ->
                        Neighbors1 = Neighbors
                    end,

                    % Operation: CurrentNum / 5 (if divisible)
                    if CurrentNum rem 5 == 0 ->
                        Neighbors2 = [{CurrentNum div 5, Steps + 1} | Neighbors1];
                    true ->
                        Neighbors2 = Neighbors1
                    end,

                    % Operations to reach a multiple of 11 and then divide
                    Rem11 = CurrentNum rem 11,
                    Neighbors3 = 
                        if Rem11 /= 0 ->
                            % Option 1: CurrentNum - Rem11, then divide by 11
                            NextNum11_minus = CurrentNum - Rem11,
                            NewSteps11_minus = Steps + Rem11 + 1,

                            % Option 2: CurrentNum + (11 - Rem11), then divide by 11
                            NextNum11_plus = CurrentNum + (11 - Rem11),
                            NewSteps11_plus = Steps + (11 - Rem11) + 1,

                            N1 = if NextNum11_minus >= 0 -> [{NextNum11_minus, NewSteps11_minus} | Neighbors2]; true -> Neighbors2 end,
                            % Add NextNum11_plus if it's not excessively large.
                            % The upper bound for states to explore is roughly Y + 11.
                            % If CurrentNum itself is already very large, CurrentNum + (11-Rem11) might be too far.
                            % The pruning condition below (NewSteps + abs(NextNum - Y) < NewMinTotalSteps) handles this implicitly.
                            [{NextNum11_plus, NewSteps11_plus} | N1];
                        true ->
                            Neighbors2
                        end,

                    % Operations to reach a multiple of 5 and then divide
                    Rem5 = CurrentNum rem 5,
                    Neighbors4 = 
                        if Rem5 /= 0 ->
                            % Option 1: CurrentNum - Rem5, then divide by 5
                            NextNum5_minus = CurrentNum - Rem5,
                            NewSteps5_minus = Steps + Rem5 + 1,

                            % Option 2: CurrentNum + (5 - Rem5), then divide by 5
                            NextNum5_plus = CurrentNum + (5 - Rem5),
                            NewSteps5_plus = Steps + (5 - Rem5) + 1,

                            N2 = if NextNum5_minus >= 0 -> [{NextNum5_minus, NewSteps5_minus} | Neighbors3]; true -> Neighbors3 end,
                            [{NextNum5_plus, NewSteps5_plus} | N2];
                        true ->
                            Neighbors3
                        end,

                    {NewPQ, NewDist} = lists:foldl(
                        fun({NextNum, NewSteps}, {AccPQ, AccDist}) ->
                            % Pruning: if the path through NextNum to Y is already worse than NewMinTotalSteps, skip
                            % This is the key optimization for large X, Y to limit the state space.
                            if NewSteps + abs(NextNum - Y) >= NewMinTotalSteps ->
                                {AccPQ, AccDist};
                            true ->
                                case maps:get(NextNum, AccDist, infinity()) of
                                    ExistingSteps when ExistingSteps <= NewSteps ->
                                        {AccPQ, AccDist}; % Already found a shorter or equal path to NextNum
                                    _ ->
                                        {gb_trees:insert({NewSteps, NextNum}, AccPQ), maps:put(NextNum, NewSteps, AccDist)}
                                end
                            end
                        end,
                        {PQ1, Dist},
                        Neighbors4
                    ),
                    dijkstra(NewPQ, NewDist, Y, NewMinTotalSteps)
            end
    end.

infinity() -> 1 bsl 60.