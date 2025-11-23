-module(solution).
-export([isCompleteTree/1]).

isCompleteTree(Root) ->
    case Root of
        nil ->
            true; % An empty tree is considered complete.
        _ ->
            % Initialize a queue with the root node.
            % The 'found_null' flag tracks if we have encountered a nil node.
            % Once 'found_null' is true, all subsequent dequeued nodes must also be nil.
            Queue = queue:in(Root, queue:new()),
            bfs_check(Queue, false)
    end.

bfs_check(Queue, FoundNull) ->
    case queue:out(Queue) of
        {{value, Node}, NewQueue} ->
            case Node of
                nil ->
                    % If we dequeue a nil node, set 'found_null' to true.
                    % All subsequent nodes must be nil.
                    bfs_check(NewQueue, true);
                {_, Left, Right} ->
                    % If we dequeue a non-nil node:
                    case FoundNull of
                        true ->
                            % If 'found_null' is already true, it means we found a
                            % non-nil node after a nil node, so the tree is not complete.
                            false;
                        false ->
                            % If 'found_null' is false, enqueue its children and continue.
                            QueueWithLeft = queue:in(Left, NewQueue),
                            QueueWithBoth = queue:in(Right, QueueWithLeft),
                            bfs_check(QueueWithBoth, FoundNull)
                    end
            end;
        {empty, _} ->
            % The queue is empty, all nodes have been processed, and no violation was found.
            true
    end.