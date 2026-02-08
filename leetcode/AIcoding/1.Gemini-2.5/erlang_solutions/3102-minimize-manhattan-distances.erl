-module(solution).
-export([min_manhattan_distances/1]).

min_manhattan_distances(Points) ->
    N = length(Points),
    if N =:= 1 ->
        0;
    true ->
        % Step 1: Transform points from (x, y) to (u, v) coordinates
        TransformedPoints = lists:map(fun([X, Y]) -> {X + Y, X - Y} end, Points),

        % Step 2: Extract U and V values into separate lists
        U_values = lists:map(fun({U, _V}) -> U end, TransformedPoints),
        V_values = lists:map(fun({_U, V}) -> V end, TransformedPoints),

        % Step 3: Sort U and V values to find the first and second min/max
        U_sorted = lists:sort(U_values),
        V_sorted = lists:sort(V_values),

        % Determine U_min1 (smallest U), U_max1 (largest U)
        U_min1 = hd(U_sorted),
        U_max1 = lists:last(U_sorted),
        % Determine U_min2 (second smallest U), U_max2 (second largest U)
        U_min2 = find_second_min(U_sorted, U_min1),
        U_max2 = find_second_max(U_sorted, U_max1),

        % Determine V_min1 (smallest V), V_max1 (largest V)
        V_min1 = hd(V_sorted),
        V_max1 = lists:last(V_sorted),
        % Determine V_min2 (second smallest V), V_max2 (second largest V)
        V_min2 = find_second_min(V_sorted, V_min1),
        V_max2 = find_second_max(V_sorted, V_max1),

        % Step 4: Iterate through each transformed point and calculate the maximum Manhattan distance
        % to all other points, then find the minimum among these maximums.
        % InitialMinManhattanDist is set to a value larger than any possible distance (max 4 * 10^8).
        InitialMinManhattanDist = 400_000_001, 
        lists:foldl(fun({Uk, Vk}, CurrentMinManhattanDist) ->
            % Calculate max distance for U coordinate, excluding Uk itself
            CurrentMaxUDist = calculate_max_dist(Uk, U_min1, U_min2, U_max1, U_max2),
            % Calculate max distance for V coordinate, excluding Vk itself
            CurrentMaxVDist = calculate_max_dist(Vk, V_min1, V_min2, V_max1, V_max2),
            % The Manhattan distance is the maximum of the U and V distances
            CurrentResult = max(CurrentMaxUDist, CurrentMaxVDist),
            min(CurrentMinManhattanDist, CurrentResult)
        end, InitialMinManhattanDist, TransformedPoints)
    end.

find_second_min(SortedList, Min1) ->
    case lists:dropwhile(fun(X) -> X =:= Min1 end, SortedList) of
        [] -> Min1; % All values are Min1, or only one distinct value
        [H|_T] -> H
    end.

find_second_max(SortedList, Max1) ->
    case lists:reverse(lists:dropwhile(fun(X) -> X =:= Max1 end, lists:reverse(SortedList))) of
        [] -> Max1; % All values are Max1, or only one distinct value
        L -> lists:last(L)
    end.

calculate_max_dist(Coord, Min1, Min2, Max1, Max2) ->
    % Determine the effective minimum value among other points
    EffectiveMin = if Coord =:= Min1 -> Min2; true -> Min1 end,
    % Determine the effective maximum value among other points
    EffectiveMax = if Coord =:= Max1 -> Max2; true -> Max1 end,
    % The maximum distance from Coord is to either the effective min or effective max
    max(abs(Coord - EffectiveMin), abs(EffectiveMax - Coord)).