-module(solution).
-export([findBestValue/2]).

calculate_sum(Arr, Value) ->
    lists:foldl(fun(X, Acc) ->
        Acc + min(X, Value)
    end, 0, Arr).

binary_search_lower_bound(Low, High, Arr, Target, Ans) when Low =< High ->
    Mid = Low + (High - Low) div 2, % Integer division
    Sum = calculate_sum(Arr, Mid),

    if
        Sum >= Target ->
            % Mid is a potential answer, try to find a smaller one in the left half
            binary_search_lower_bound(Low, Mid - 1, Arr, Target, Mid);
        true -> % Sum < Target
            % Mid is too small, search in the right half
            binary_search_lower_bound(Mid + 1, High, Arr, Target, Ans)
    end;
binary_search_lower_bound(_Low, _High, _Arr, _Target, Ans) ->
    Ans. % Return the smallest 'value' found that satisfies the condition

findBestValue(Arr, Target) ->
    % The search space for 'value' is [0, MaxArrElement].
    % If 'value' is greater than max(Arr), the sum is sum(Arr).
    % So, max(Arr) is a sufficient upper bound for the binary search.
    MaxArrElement = lists:foldl(fun(X, Acc) -> max(X, Acc) end, 0, Arr),

    % Perform binary search to find the smallest 'value' (ResVal)
    % such that calculate_sum(Arr, ResVal) >= Target.
    % Initialize Ans with MaxArrElement as the largest possible candidate.
    ResVal = binary_search_lower_bound(0, MaxArrElement, Arr, Target, MaxArrElement),

    % Now we compare ResVal and ResVal - 1 (if ResVal > 0)
    % to find the one that gives the sum closest to Target,
    % preferring the smaller value in case of a tie.

    SumResVal = calculate_sum(Arr, ResVal),
    DiffResVal = abs(SumResVal - Target),

    if
        ResVal == 0 ->
            % If ResVal is 0, we can't check ResVal - 1.
            % The only option is 0.
            0;
        true ->
            SumResValMinus1 = calculate_sum(Arr, ResVal - 1),
            DiffResValMinus1 = abs(SumResValMinus1 - Target),

            if
                DiffResVal < DiffResValMinus1 ->
                    ResVal;
                DiffResVal > DiffResValMinus1 ->
                    ResVal - 1;
                true -> % DiffResVal == DiffResValMinus1
                    % Return the smaller value in case of a tie
                    ResVal - 1
            end
    end.