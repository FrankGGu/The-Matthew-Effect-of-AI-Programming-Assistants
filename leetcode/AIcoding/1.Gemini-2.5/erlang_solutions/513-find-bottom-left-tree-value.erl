-module(solution).
-export([findBottomLeftValue/1]).

findBottomLeftValue(Root) ->
    case Root of
        nil ->
            % According to LeetCode problem constraints, root is usually not nil.
            % If it could be nil, the problem statement would specify what to return.
            error(empty_tree_not_allowed);
        {Val, _, _} ->
            % Start BFS. The `CurrentBottomLeftValue` is initially the root's value.
            % This value will be updated whenever we start processing a new level.
            % The last value it holds before the queue becomes empty will be the answer.
            bfs_loop(queue:in(Root, queue:new()), Val)
    end.

bfs_loop(CurrentQ, CurrentBottomLeftValue) ->
    case queue:is_empty(CurrentQ) of
        true ->
            % If the current queue is empty, it means we have processed all levels.
            % The `CurrentBottomLeftValue` holds the value of the first node of the last non-empty level.
            CurrentBottomLeftValue;
        false ->
            % Initialize for the next level
            NextQ = queue:new(),
            NextLevelFirstValue = CurrentBottomLeftValue, % Temporary placeholder, will be updated if children exist
            IsFirstChildEnqueued = false,

            % Process all nodes in the CurrentQ (current level)
            % This function will return the populated NextQ and the value of its first node
            {FinalNextQ, FinalNextLevelFirstValue} =
                process_current_level(CurrentQ, NextQ, NextLevelFirstValue, IsFirstChildEnqueued),

            % Recurse with the next level's queue and its first node's value
            bfs_loop(FinalNextQ, FinalNextLevelFirstValue)
    end.

process_current_level(CurrentQ, NextQAcc, NextLevelFirstValAcc, IsFirstChildEnqueuedAcc) ->
    case queue:is_empty(CurrentQ) of
        true ->
            % All nodes in the current level have been processed
            {NextQAcc, NextLevelFirstValAcc};
        false ->
            % Dequeue a node from the current level
            {ok, {Val, Left, Right}, Q_rest} = queue:out(CurrentQ),

            % Enqueue left child if it exists
            {NewNextQAcc1, NewNextLevelFirstValAcc1, NewIsFirstChildEnqueuedAcc1} =
                enqueue_child(Left, NextQAcc, NextLevelFirstValAcc, IsFirstChildEnqueuedAcc),

            % Enqueue right child if it exists
            {NewNextQAcc2, NewNextLevelFirstValAcc2, NewIsFirstChildEnqueuedAcc2} =
                enqueue_child(Right, NewNextQAcc1, NewNextLevelFirstValAcc1, NewIsFirstChildEnqueuedAcc1),

            % Continue processing the rest of the current level
            process_current_level(Q_rest, NewNextQAcc2, NewNextLevelFirstValAcc2, NewIsFirstChildEnqueuedAcc2)
    end.

enqueue_child(nil, QAcc, FirstValAcc, IsFirstChildEnqueuedAcc) ->
    % No child to enqueue, return accumulators as they are
    {QAcc, FirstValAcc, IsFirstChildEnqueuedAcc};
enqueue_child({ChildVal, _, _} = ChildNode, QAcc, FirstValAcc, IsFirstChildEnqueuedAcc) ->
    % Enqueue the child node
    NewQAcc = queue:in(ChildNode, QAcc),

    case IsFirstChildEnqueuedAcc of
        true ->
            % A child has already been enqueued for the next level, so FirstValAcc is already set
            {NewQAcc, FirstValAcc, true};
        false ->
            % This is the first child being enqueued for the next level, update FirstValAcc
            {NewQAcc, ChildVal, true}
    end.