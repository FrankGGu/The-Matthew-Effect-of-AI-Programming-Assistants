-module(solution).
-export([max_sum_non_adjacent/1]).

max_sum_non_adjacent([]) -> 0;
max_sum_non_adjacent(List) ->
    MaxElement = lists:max(List),
    if
        MaxElement =< 0 ->
            % If all elements are non-positive, the maximum sum is the largest (least negative) element.
            % An empty subsequence (sum 0) is not allowed unless explicitly stated.
            MaxElement;
        true ->
            % Dynamic programming approach:
            % inc: maximum sum of a non-adjacent subsequence ending with the current element.
            % exc: maximum sum of a non-adjacent subsequence not ending with the current element
            %      (i.e., maximum sum up to the previous element, which could have included or excluded the previous element).

            % Initial state before processing any element:
            % inc_prev = 0 (no element picked yet, so sum ending with it is 0)
            % exc_prev = 0 (no element picked yet, so sum not ending with it is 0)
            {FinalInc, FinalExc} = lists:foldl(
                fun(Element, {Inc_prev, Exc_prev}) ->
                    % If we include the current Element:
                    %   We must not have included the previous element.
                    %   So, we add Element to the max sum not including the previous element (Exc_prev).
                    Current_Inc = Element + Exc_prev,

                    % If we do NOT include the current Element:
                    %   The max sum up to this point (excluding current) is either:
                    %     1. The max sum including the previous element (Inc_prev).
                    %     2. The max sum not including the previous element (Exc_prev).
                    Current_Exc = max(Inc_prev, Exc_prev),
                    {Current_Inc, Current_Exc}
                end,
                {0, 0}, % Initial accumulator: {Inc_prev, Exc_prev}
                List
            ),
            % The final result is the maximum of:
            %   1. Max sum ending with the last element (FinalInc).
            %   2. Max sum not ending with the last element (FinalExc).
            max(FinalInc, FinalExc)
    end.