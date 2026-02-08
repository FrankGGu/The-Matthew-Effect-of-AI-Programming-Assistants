-module(solution).
-export([carPooling/2]).

carPooling(Trips, Capacity) ->
    % The maximum possible 'to' location is 1000.
    % We need a difference array that covers locations from 0 to 1000.
    % So, the size of the array should be 1001 (for indices 0 to 1000).
    MaxLocation = 1000,
    DiffArraySize = MaxLocation + 1,

    % Initialize a list of zeros to represent the net change in passengers at each location.
    InitialDiffArray = lists:duplicate(DiffArraySize, 0),

    % Apply changes from each trip to the difference array.
    % For each trip [P, From, To]:
    %   Add P passengers at 'From' location.
    %   Subtract P passengers at 'To' location (as they exit there).
    FinalDiffArray = lists:foldl(
        fun([Passengers, From, To], CurrentDiff) ->
            % Add passengers at the 'From' location
            UpdatedDiff1 = update_list_at(From, Passengers, CurrentDiff),
            % Subtract passengers at the 'To' location
            update_list_at(To, -Passengers, UpdatedDiff1)
        end,
        InitialDiffArray,
        Trips
    ),

    % Iterate through the final difference array to calculate the current number of passengers
    % and check if it ever exceeds the capacity.
    check_capacity(FinalDiffArray, Capacity, 0).

update_list_at(Index, Value, List) ->
    % lists:sublist(List, 1, Index) gets elements from 0 to Index-1 (0-indexed)
    % lists:nth(Index + 1, List) gets the element at Index (0-indexed)
    % lists:nthtail(Index + 1, List) gets the tail starting from Index+1 (0-indexed)
    lists:sublist(List, 1, Index) ++ [lists:nth(Index + 1, List) + Value] ++ lists:nthtail(Index + 1, List).

check_capacity([], _Capacity, _CurrentPassengers) ->
    true; % All locations processed, capacity never exceeded
check_capacity([Change | Rest], Capacity, CurrentPassengers) ->
    NewPassengers = CurrentPassengers + Change,
    if NewPassengers > Capacity ->
        false; % Capacity exceeded
    true ->
        check_capacity(Rest, Capacity, NewPassengers)
    end.