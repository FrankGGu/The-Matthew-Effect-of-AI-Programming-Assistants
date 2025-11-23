-module(solution).
-export([lexical_order/2]).

lexical_order(N, K) ->
    % K is 1-indexed, convert to 0-indexed for easier calculation
    lexical_order_loop(N, K - 1, 1).

lexical_order_loop(N, K_zero_indexed, Current) ->
    % If K_zero_indexed is 0, Current is the K-th smallest number.
    if K_zero_indexed == 0 ->
        Current;
    true ->
        % Calculate the number of elements in the lexicographical subtree rooted at Current,
        % including Current itself, that are less than or equal to N.
        Steps = count_steps(Current, N),

        if K_zero_indexed >= Steps ->
            % The K-th number is not in the subtree rooted at Current.
            % We need to skip this entire subtree.
            % Decrement K_zero_indexed by the number of steps in this subtree.
            % Move to the next "sibling" prefix.
            NewK = K_zero_indexed - Steps,
            NewCurrent = Current + 1,
            % Adjust Current: if it ends in 0 (e.g., 20 from 19+1),
            % it means we've moved past a full branch (e.g., 10-19) and need to go up (to 2).
            AdjustedCurrent = adjust_current_up(NewCurrent),
            lexical_order_loop(N, NewK, AdjustedCurrent);
        true ->
            % The K-th number is in the subtree rooted at Current or one of its children.
            % We "consume" Current itself (decrement K_zero_indexed by 1)
            % and go deeper into its children.
            NewK = K_zero_indexed - 1,
            NewCurrent = Current * 10,
            lexical_order_loop(N, NewK, NewCurrent)
        end
    end.

adjust_current_up(Current) ->
    if Current rem 10 == 0 ->
        adjust_current_up(Current div 10);
    true ->
        Current
    end.

count_steps(Current, N) ->
    count_steps_recursive(Current, Current, N, 0).

count_steps_recursive(First, Last, N, Acc) ->
    if First > N ->
        Acc;
    true ->
        % The number of elements in the current range [First, Last] that are <= N
        % is min(N, Last) - First + 1.
        NewAcc = Acc + min(N, Last) - First + 1,
        % Move to the next level of the subtree (e.g., from 1 to 10-19)
        count_steps_recursive(First * 10, Last * 10 + 9, N, NewAcc)
    end.