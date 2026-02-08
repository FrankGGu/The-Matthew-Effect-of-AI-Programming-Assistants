-module(solution).
-export([maximum_requests/2]).

maximum_requests(N, Requests) ->
    % Initialize the delta for all buildings to 0.
    % Delta is represented as a tuple of size N, where each element
    % corresponds to the net change in employees for a building.
    % Tuple indices are 1-based, so building 'i' (0-indexed) maps to tuple element 'i+1'.
    InitialDelta = list_to_tuple(lists:duplicate(N, 0)),

    % Start the recursive search.
    % The function will return the maximum number of achievable requests.
    solve(Requests, 0, InitialDelta).

solve([], CurrentRequestsCount, CurrentDelta) ->
    % Base case: All requests have been considered.
    % Check if the current set of chosen requests is achievable.
    % An achievable set means the net change for all buildings is zero.
    IsAchievable = lists:all(fun(X) -> X == 0 end, tuple_to_list(CurrentDelta)),
    if
        IsAchievable -> CurrentRequestsCount; % This set is achievable, return its count.
        true -> 0 % This set is not achievable, contributes 0 to the maximum.
    end;

solve([H_Request | T_Requests], CurrentRequestsCount, CurrentDelta) ->
    % Recursive step: Consider the current request H_Request.
    {From, To} = H_Request,

    % Option 1: Do not include the current request H_Request.
    % Proceed with the rest of the requests, keeping the current count and delta.
    Max1 = solve(T_Requests, CurrentRequestsCount, CurrentDelta),

    % Option 2: Include the current request H_Request.
    % Update the delta for 'From' and 'To' buildings.
    % 'From' building loses an employee (-1), 'To' building gains an employee (+1).
    % Remember to convert 0-indexed building numbers to 1-indexed tuple positions.
    NewDeltaFrom = element(From + 1, CurrentDelta) - 1,
    NewDeltaTo = element(To + 1, CurrentDelta) + 1,

    % Create a new delta tuple with updated values.
    UpdatedDelta = setelement(From + 1, CurrentDelta, NewDeltaFrom),
    UpdatedDelta2 = setelement(To + 1, UpdatedDelta, NewDeltaTo),

    % Proceed with the rest of the requests, incrementing the count and using the updated delta.
    Max2 = solve(T_Requests, CurrentRequestsCount + 1, UpdatedDelta2),

    % Return the maximum number of achievable requests from these two options.
    max(Max1, Max2).