-module(solution).
-export([countVisitedNodes/1]).

countVisitedNodes(EdgesList) ->
    N = length(EdgesList),
    Edges = array:from_list(EdgesList),
    Answer = array:new(N, {default, 0}),
    FinalAnswer = solve_helper(0, N, Edges, Answer),
    array:to_list(FinalAnswer).

solve_helper(NodeIdx, N, Edges, Answer) when NodeIdx == N ->
    Answer;
solve_helper(NodeIdx, N, Edges, Answer) ->
    CurrentAnswerVal = array:get(NodeIdx, Answer),
    If CurrentAnswerVal /= 0 ->
        solve_helper(NodeIdx + 1, N, Edges, Answer);
    Else ->
        NewAnswer = traverse(NodeIdx, [], #{}, Edges, Answer),
        solve_helper(NodeIdx + 1, N, Edges, NewAnswer)
    End.

traverse(CurrentNode, PathStack, PathMap, Edges, Answer) ->
    Depth = length(PathStack), % Current depth if CurrentNode were added to PathStack

    % Case 1: CurrentNode has been globally processed (part of another path/cycle)
    CurrentAnswerVal = array:get(CurrentNode, Answer),
    If CurrentAnswerVal /= 0 ->
        Len = CurrentAnswerVal,
        {FinalAnswer, _} = lists:foldl(
            fun(PNode, {AccAns, AccLen}) ->
                {array:set(PNode, AccLen + 1, AccAns), AccLen + 1}
            end,
            {Answer, Len},
            lists:reverse(PathStack) % Process nodes in PathStack from oldest to newest
        ),
        FinalAnswer;

    % Case 2: Cycle detected (CurrentNode is in the current path)
    Else If maps:is_key(CurrentNode, PathMap) ->
        CycleStartDepth = maps:get(CurrentNode, PathMap),
        CycleLength = Depth - CycleStartDepth,

        TempAnswer = Answer,

        % Update nodes in the cycle
        % These are nodes in PathStack whose depth in PathMap is >= CycleStartDepth.
        NodesInCycle = lists:filter(fun(PNode) -> maps:get(PNode, PathMap) >= CycleStartDepth end, PathStack),
        UpdatedAnswer1 = lists:foldl(fun(NodeInCycle, AccAns) ->
                                        array:set(NodeInCycle, CycleLength, AccAns)
                                     end, TempAnswer, NodesInCycle),

        % Update nodes leading to the cycle
        % These are nodes in PathStack whose depth in PathMap is < CycleStartDepth.
        NodesBeforeCycle = lists:filter(fun(PNode) -> maps:get(PNode, PathMap) < CycleStartDepth end, PathStack),
        {FinalAnswer, _} = lists:foldl(
            fun(NodeBeforeCycle, {AccAns, CurrentLen}) ->
                {array:set(NodeBeforeCycle, CurrentLen + 1, AccAns), CurrentLen + 1}
            end,
            {UpdatedAnswer1, CycleLength},
            lists:reverse(NodesBeforeCycle) % Process nodes from oldest to newest
        ),
        FinalAnswer;

    % Case 3: Continue traversal (CurrentNode is new to this path and not globally processed)
    Else ->
        NextNode = array:get(CurrentNode, Edges),
        NewPathStack = [CurrentNode | PathStack], % Prepend CurrentNode to PathStack
        NewPathMap = maps:put(CurrentNode, Depth, PathMap),
        traverse(NextNode, NewPathStack, NewPathMap, Edges, Answer)
    End.