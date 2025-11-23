-module(solution).
-export([max_value_equation/2]).

max_value_equation(Points, K) ->
    % Initial maximum value is set to a sufficiently small number.
    % The minimum possible value for the equation yi + yj + |xi - xj| is
    % approximately -10^9 - 10^9 + (min_xj - max_xi) = -2*10^9 - 2*10^9 = -4*10^9.
    InitialMaxVal = -4000000000, 

    % The foldl accumulator will be {MaxValAcc, DequeAcc}.
    % DequeAcc stores tuples of {Yi_minus_Xi, Xi}.
    % It maintains elements such that Yi_minus_Xi values are in decreasing order.
    {FinalMaxVal, _FinalDeque} = lists:foldl(
        fun([Xj, Yj], {MaxValAcc, DequeAcc}) ->
            % Step 1: Remove points from the front of the deque that are too far left.
            % These points no longer satisfy the condition Xj - Xi <= K.
            NewDeque1 = clean_front(Xj, K, DequeAcc),

            % Step 2: If the deque is not empty, calculate the potential maximum value
            % using the best candidate point (which is at the front of the deque).
            CurrentPotentialMax = 
                case queue:peek(NewDeque1) of
                    {value, {Yi_minus_Xi, _Xi}} ->
                        % Equation is (Yi - Xi) + (Yj + Xj)
                        Yi_minus_Xi + (Yj + Xj);
                    _ -> % Deque is empty, no valid 'i' point found yet for current 'j'.
                        MaxValAcc % Keep the accumulated maximum value.
                end,

            % Update the overall maximum value found so far.
            UpdatedMaxValAcc = max(MaxValAcc, CurrentPotentialMax),

            % Step 3: Remove points from the back of the deque that are inferior to the current point [Xj, Yj].
            % An inferior point [Xi_prev, Yi_prev] has (Yi_prev - Xi_prev) <= (Yj - Xj).
            % Since points are processed in increasing order of X, a new point [Xj, Yj]
            % that offers a better or equal (Y - X) value will always be preferred over
            % older, inferior points for any future 'j' points.
            Yj_minus_Xj = Yj - Xj,
            NewDeque2 = clean_back(Yj_minus_Xj, NewDeque1),

            % Step 4: Add the current point's value to the back of the deque.
            FinalDequeAcc = queue:in({Yj_minus_Xj, Xj}, NewDeque2),

            {UpdatedMaxValAcc, FinalDequeAcc}
        end,
        {InitialMaxVal, queue:new()}, % Initial accumulator: {MaxVal, EmptyDeque}
        Points
    ),
    FinalMaxVal.

clean_front(Xj, K, Deque) ->
    case queue:peek(Deque) of
        {value, {_Yi_minus_Xi, Xi}} when Xj - Xi > K ->
            {_Value, TempDeque} = queue:out(Deque),
            clean_front(Xj, K, TempDeque);
        _ ->
            Deque
    end.

clean_back(Yj_minus_Xj, Deque) ->
    case queue:peek_r(Deque) of
        {value, {Yi_minus_Xi, _Xi}} when Yi_minus_Xi =< Yj_minus_Xj ->
            {_Value, TempDeque} = queue:out_r(Deque),
            clean_back(Yj_minus_Xj, TempDeque);
        _ ->
            Deque
    end.