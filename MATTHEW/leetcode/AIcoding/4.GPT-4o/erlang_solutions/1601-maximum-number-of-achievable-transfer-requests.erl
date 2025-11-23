-module(solution).
-export([maximum_achievable_requests/2]).

maximum_achievable_requests(N, Requests) ->
    max_achievable_requests(N, Requests, 0, 0).

max_achievable_requests(_, [], Achieved, Max) ->
    if 
        Achieved > Max -> Achieved;
        true -> Max
    end;

max_achievable_requests(N, [{From, To} | Rest], Achieved, Max) ->
    NewAchieved = Achieved + 1,
    max_achievable_requests(N, Rest, NewAchieved, Max),
    max_achievable_requests(N, Rest, Achieved, Max).