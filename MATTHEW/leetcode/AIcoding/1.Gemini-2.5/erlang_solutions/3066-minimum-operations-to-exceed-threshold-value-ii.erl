-module(solution).
-export([min_operations/2]).

min_operations(Nums, K) ->
    % Build initial priority queue using a gb_tree.
    % The key is the number, and the value is its count.
    % gb_trees:enter(Key, UpdateFun, InsertValue, Tree)
    % If Key exists, UpdateFun(ExistingValue) is used to update its value.
    % If Key does not exist, InsertValue is used as its value.
    PQ = lists:foldl(fun(N, Acc) ->
                             gb_trees:enter(N,
                                            fun(Count) -> Count + 1 end,
                                            1, % If N is a new number, its count starts at 1
                                            Acc)
                     end, gb_trees:empty(), Nums),

    solve(PQ, K, 0).

solve(PQ, K, Ops) ->
    % Check if the priority queue is empty.
    % If empty, no more operations can be performed, and all previous elements must have met the threshold.
    case gb_trees:is_empty(PQ) of
        true ->
            Ops;
        false ->
            % Get the smallest element from the priority queue.
            {Min1, _} = gb_trees:smallest(PQ),

            % If the smallest element is already greater than or equal to K,
            % then all elements in the queue must be >= K, so we are done.
            if Min1 >= K ->
                Ops;
            true ->
                % The smallest element (Min1) is less than K. An operation is needed.
                % First, extract Min1.
                {Min1_val, Min1_count} = gb_trees:smallest(PQ),
                NewPQ1 =
                    if Min1_count > 1 ->
                        % If Min1 has duplicates, decrement its count.
                        gb_trees:update(Min1_val, fun(C) -> C - 1 end, PQ);
                    true ->
                        % If Min1 is unique, remove it from the tree.
                        gb_trees:delete(Min1_val, PQ)
                    end,

                % Now, try to extract the second smallest element.
                % If NewPQ1 is empty, it means we only had one element (Min1) initially,
                % and it was less than K. We cannot perform an operation.
                case gb_trees:is_empty(NewPQ1) of
                    true ->
                        Ops; % Cannot perform operation, return current count.
                    false ->
                        % Extract the second smallest element (Min2).
                        {Min2_val, Min2_count} = gb_trees:smallest(NewPQ1),
                        NewPQ2 =
                            if Min2_count > 1 ->
                                % If Min2 has duplicates, decrement its count.
                                gb_trees:update(Min2_val, fun(C) -> C - 1 end, NewPQ1);
                            true ->
                                % If Min2 is unique, remove it from the tree.
                                gb_trees:delete(Min2_val, NewPQ1)
                            end,

                        % Perform the operation: combine Min1 and Min2.
                        Combined = Min1_val * 2 + Min2_val,

                        % Insert the combined value back into the priority queue.
                        FinalPQ = gb_trees:enter(Combined,
                                                 fun(C) -> C + 1 end,
                                                 1, % If Combined is new, start count at 1
                                                 NewPQ2),

                        % Recursively call solve with the updated queue and incremented operations count.
                        solve(FinalPQ, K, Ops + 1)
                end
            end
    end.