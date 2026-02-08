-module(solution).
-export([solve/1]).

solve(Nums) ->
    % Acc = {CurrentHealth, InitialHealthRequired, PriorityQueue, CounterForUniqueKeys}
    % CurrentHealth: The running sum of health changes, assuming 0 initial health and optimal skips.
    % InitialHealthRequired: The minimum initial health needed. Starts at 1.
    % PriorityQueue: Stores {AbsValue, UniqueCounter} -> AbsValue for all negative numbers encountered so far.
    % CounterForUniqueKeys: Used to generate unique keys for gb_trees when AbsValue might be duplicated.
    {_FinalCurrentHealth, InitialHealthRequired, _FinalPQ, _FinalCounter} =
        lists:foldl(
            fun(X, {CurrentHealth, InitialHealthRequired, PQ, Counter}) ->
                NewCounter = Counter + 1,
                NewCurrentHealth = CurrentHealth + X,

                % Add absolute value of negative health changes to the priority queue
                % The key is {AbsValue, UniqueCounter} to handle duplicate negative values
                NewPQ = 
                    case X < 0 of
                        true -> gb_trees:insert({-X, NewCounter}, -X, PQ);
                        false -> PQ
                    end,

                % If current health drops below 0, we must compensate.
                % We do this by effectively "skipping" the largest negative health change encountered so far.
                % The cost of this skipped health change is added to InitialHealthRequired.
                {UpdatedCurrentHealth, UpdatedInitialHealthRequired, UpdatedPQ} =
                    case NewCurrentHealth < 0 of
                        true ->
                            % If current_health is negative, we must use a "skip" to compensate.
                            % We pick the largest absolute negative value from the priority queue.
                            % This effectively means we "undo" the effect of that negative value.
                            % The amount of health we "saved" by skipping this negative value
                            % must be covered by our initial health.
                            case gb_trees:is_empty(NewPQ) of
                                true -> 
                                    % This case indicates that current_health dropped below 0
                                    % but there are no negative numbers in the history to skip.
                                    % This scenario should not occur based on problem constraints
                                    % and the logic that negative X values are added to PQ.
                                    % If it were to happen, it means we cannot compensate by skipping,
                                    % and the initial health would need to be increased directly.
                                    % However, for this specific LeetCode problem, this branch is not expected.
                                    {NewCurrentHealth, InitialHealthRequired, NewPQ};
                                false ->
                                    {{ValToSkipAbs, KeyCounter}, _} = gb_trees:max(NewPQ), % Get the largest AbsValue and its unique key
                                    TempPQ = gb_trees:delete({ValToSkipAbs, KeyCounter}, NewPQ), % Remove it from PQ

                                    % Undo the effect of the skipped negative value on current_health
                                    % (i.e., add its absolute value back to current_health)
                                    TempCurrentHealth = NewCurrentHealth + ValToSkipAbs,

                                    % The amount of health we "saved" by skipping this negative value
                                    % must be covered by our initial health.
                                    TempInitialHealthRequired = InitialHealthRequired + ValToSkipAbs,

                                    {TempCurrentHealth, TempInitialHealthRequired, TempPQ}
                            end;
                        false ->
                            {NewCurrentHealth, InitialHealthRequired, NewPQ}
                    end,

                {UpdatedCurrentHealth, UpdatedInitialHealthRequired, UpdatedPQ, NewCounter}
            end,
            {0, 1, gb_trees:empty(), 0}, % Initial state: CurrentHealth=0, InitialHealthRequired=1, PQ=empty, Counter=0
            Nums
        ),
    InitialHealthRequired.