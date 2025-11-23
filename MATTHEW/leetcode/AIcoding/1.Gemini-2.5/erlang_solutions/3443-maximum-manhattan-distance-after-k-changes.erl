-module(solution).
-export([max_manhattan_distance_after_k_changes/2]).

max_manhattan_distance_after_k_changes(Points, K) ->
    N = length(Points),

    % If N is 1, the maximum distance is always 0, regardless of K.
    % We can change the only point, but there's still only one point, so distance to itself is 0.
    if N == 1 ->
        0;
    true ->
        % Define a large constant for coordinate bounds.
        % Max possible value for x or y is 10^9.
        % So max possible x+y or x-y is 2*10^9.
        % Min possible x+y or x-y is -2*10^9.
        INF_VALUE = 2 * 1000000000, % 2 * 10^9

        % Calculate u = x + y and v = x - y for all points.
        U_values = lists:map(fun([X, Y]) -> X + Y end, Points),
        V_values = lists:map(fun([X, Y]) -> X - Y end, Points),

        if K == 0 ->
            % If no changes allowed, simply find the max Manhattan distance among original points.
            % Max Manhattan distance is max(max(u) - min(u), max(v) - min(v)).
            Max_U = lists:max(U_values),
            Min_U = lists:min(U_values),
            Max_V = lists:max(V_values),
            Min_V = lists:min(V_values),
            max(Max_U - Min_U, Max_V - Min_V);
        true -> % K >= 1
            % If at least one change is allowed, we can move one point to an extreme position
            % to maximize the range of u or v.
            % We need to consider each point as the one being moved.
            % To do this efficiently, we find the two smallest and two largest u and v values.

            % Sort U and V values to easily find min/max and second min/max.
            U_sorted = lists:sort(U_values),
            V_sorted = lists:sort(V_values),

            % Find the smallest u value (MinU1) and the second smallest (MinU2).
            % If all values are the same, MinU2 will be MinU1.
            MinU1 = hd(U_sorted),
            MinU2 = case lists:dropwhile(fun(X) -> X == MinU1 end, U_sorted) of
                        [] -> MinU1; % All U values are the same
                        [H|_] -> H
                    end,

            % Find the largest u value (MaxU1) and the second largest (MaxU2).
            MaxU1 = lists:last(U_sorted),
            MaxU2 = case lists:reverse(lists:dropwhile(fun(X) -> X == MaxU1 end, lists:reverse(U_sorted))) of
                        [] -> MaxU1; % All U values are the same
                        [H|_] -> H
                    end,

            % Same for V values.
            MinV1 = hd(V_sorted),
            MinV2 = case lists:dropwhile(fun(X) -> X == MinV1 end, V_sorted) of
                        [] -> MinV1;
                        [H|_] -> H
                    end,

            MaxV1 = lists:last(V_sorted),
            MaxV2 = case lists:reverse(lists:dropwhile(fun(X) -> X == MaxV1 end, lists:reverse(V_sorted))) of
                        [] -> MaxV1;
                        [H|_] -> H
                    end,

            % Iterate through each point and calculate the maximum possible distance
            % if that point is chosen for modification.
            % Initialize with 0 as distances are non-negative.
            MaxOverallDistance = 0,
            lists:foldl(fun([X, Y], AccMax) ->
                U_val = X + Y,
                V_val = X - Y,

                % Determine the min/max u values if U_val is removed.
                CurrentMinU = if U_val == MinU1 -> MinU2; true -> MinU1 end,
                CurrentMaxU = if U_val == MaxU1 -> MaxU2; true -> MaxU1 end,

                % Calculate the maximum possible u-range by moving U_val to an extreme.
                % Either move it to INF_VALUE, or to -INF_VALUE.
                CurrentURange = max(INF_VALUE - CurrentMinU, CurrentMaxU - (-INF_VALUE)),

                % Determine the min/max v values if V_val is removed.
                CurrentMinV = if V_val == MinV1 -> MinV2; true -> MinV1 end,
                CurrentMaxV = if V_val == MaxV1 -> MaxV2; true -> MaxV1 end,

                % Calculate the maximum possible v-range by moving V_val to an extreme.
                CurrentVRange = max(INF_VALUE - CurrentMinV, CurrentMaxV - (-INF_VALUE)),

                % Update the overall maximum distance.
                max(AccMax, max(CurrentURange, CurrentVRange))
            end, MaxOverallDistance, Points)
        end
    end.