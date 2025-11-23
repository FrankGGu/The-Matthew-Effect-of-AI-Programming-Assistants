-module(solution).
-export([validateBinaryTreeNodes/3]).

validateBinaryTreeNodes(N, LeftChildList, RightChildList) ->
    LC_Arr = array:from_list(LeftChildList),
    RC_Arr = array:from_list(RightChildList),

    % Step 1: Calculate parent counts and check for multiple parents
    % ParentCounts stores the number of parents for each node.
    % If any node gets more than one parent, it's not a valid tree.
    ParentCounts = array:new(N, [{default, 0}]),
    try
        ParentCounts1 =
            lists:foldl(fun(I, Acc) ->
                Left = array:get(I, LC_Arr),
                Right = array:get(I, RC_Arr),

                NewAcc1 =
                    if Left /= -1 ->
                        Count = array:get(Left, Acc),
                        if Count >= 1 -> % Node Left already has a parent
                            throw(false); % Indicate invalid tree
                        else
                            array:set(Left, Count + 1, Acc)
                        end;
                    true ->
                        Acc
                    end,

                if Right /= -1 ->
                    Count = array:get(Right, NewAcc1),
                    if Count >= 1 -> % Node Right already has a parent
                        throw(false); % Indicate invalid tree
                    else
                        array:set(Right, Count + 1, NewAcc1)
                    end;
                true ->
                    NewAcc1
                end
            end, ParentCounts, lists:seq(0, N-1)),

        % Step 2: Find the root (node with 0 parents)
        % There must be exactly one root.
        Root = -1,
        RootCount = 0,
        {FinalRoot, FinalRootCount} =
            lists:foldl(fun(I, {AccRoot, AccRootCount}) ->
                Count = array:get(I, ParentCounts1),
                if Count == 0 ->
                    {I, AccRootCount + 1};
                true ->
                    {AccRoot, AccRootCount}
                end
            end, {Root, RootCount}, lists:seq(0, N-1)),

        if FinalRootCount /= 1 ->
            false;
        true ->
            % Step 3: BFS traversal to check reachability and cycles
            % Queue: {Head, Tail} for BFS
            % Visited: map of visited nodes (acting as a set)
            Queue = queue:from_list([FinalRoot]),
            Visited = maps:put(FinalRoot, true, maps:new()),
            VisitedCount = 1,

            bfs(Queue, Visited, VisitedCount, LC_Arr, RC_Arr, N)
        end
    catch
        false -> false % Caught from throw(false) for multiple parents
    end.

bfs(Queue, Visited, VisitedCount, LC_Arr, RC_Arr, N) ->
    if VisitedCount == N ->
        true; % All nodes visited, and no cycles detected so far, so it's a valid tree
    true ->
        case queue:out(Queue) of
            {{value, Current}, RestQueue} ->
                Left = array:get(Current, LC_Arr),
                Right = array:get(Current, RC_Arr),

                NewQueue1 = RestQueue,
                NewVisited1 = Visited,
                NewVisitedCount1 = VisitedCount,

                % Handle Left Child
                {UpdatedQueue1, UpdatedVisited1, UpdatedVisitedCount1, Valid1} =
                    if Left /= -1 ->
                        if maps:is_key(Left, NewVisited1) ->
                            {NewQueue1, NewVisited1, NewVisitedCount1, false}; % Cycle detected
                        else
                            {queue:in(Left, NewQueue1), maps:put(Left, true, NewVisited1), NewVisitedCount1 + 1, true}
                        end;
                    true ->
                        {NewQueue1, NewVisited1, NewVisitedCount1, true}
                    end,

                if not Valid1 -> false;
                true ->
                    % Handle Right Child
                    {UpdatedQueue2, UpdatedVisited2, UpdatedVisitedCount2, Valid2} =
                        if Right /= -1 ->
                            if maps:is_key(Right, UpdatedVisited1) ->
                                {UpdatedQueue1, UpdatedVisited1, UpdatedVisitedCount1, false}; % Cycle detected
                            else
                                {queue:in(Right, UpdatedQueue1), maps:put(Right, true, UpdatedVisited1), UpdatedVisitedCount1 + 1, true}
                            end;
                        true ->
                            {UpdatedQueue1, UpdatedVisited1, UpdatedVisitedCount1, true}
                        end,

                    if not Valid2 -> false;
                    true ->
                        bfs(UpdatedQueue2, UpdatedVisited2, UpdatedVisitedCount2, LC_Arr, RC_Arr, N)
                    end
                end;
            {empty, _} ->
                % Queue is empty, but not all nodes visited.
                % This means some nodes are unreachable from the root.
                false
        end
    end.