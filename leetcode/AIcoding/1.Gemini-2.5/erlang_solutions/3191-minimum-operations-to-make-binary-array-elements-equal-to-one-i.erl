-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    N = length(Nums),
    % min_operations_loop(RemainingList, TotalLength, CurrentIndex, F1, F2, TotalOperations)
    % F1: represents the flip state from (Index-1)
    % F2: represents the flip state from (Index-2)
    % Both F1 and F2 are 0 or 1, indicating if an operation started at that previous index.
    min_operations_loop(Nums, N, 0, 0, 0, 0).

min_operations_loop([], _N, _Index, _F1, _F2, TotalOps) ->
    TotalOps;
min_operations_loop([H | T], N, Index, F1, F2, TotalOps) ->
    % Calculate the effective value of the current element H
    % based on its original value and flips from Index-1 and Index-2.
    EffectiveValBeforeOp = (H + F1 + F2) rem 2,
    case EffectiveValBeforeOp of
        0 ->
            % If the effective value is 0, we must perform an operation starting at Index
            % to make it 1.
            % An operation at Index affects Index, Index+1, Index+2.
            % So, Index + 2 must be within the array bounds (i.e., < N).
            if Index + 2 >= N ->
                    % If we cannot perform an operation here, it's impossible to make it 1.
                    -1;
               true ->
                    % Perform an operation: increment total operations,
                    % update F1 (current operation becomes F1 for next step),
                    % update F2 (previous F1 becomes F2 for next step).
                    NewF1 = 1,
                    NewF2 = F1,
                    NewTotalOps = TotalOps + 1,
                    min_operations_loop(T, N, Index + 1, NewF1, NewF2, NewTotalOps)
            end;
        1 ->
            % If the effective value is already 1, no operation is needed at Index.
            % Update F1 and F2 for the next step (no operation at current Index).
            NewF1 = 0,
            NewF2 = F1,
            min_operations_loop(T, N, Index + 1, NewF1, NewF2, TotalOps)
    end.