-module(solution).
-export([number_of_ways/2]).

number_of_ways(N, edges) ->
    Edges = lists:foldl(fun({X, Y}, Acc) -> 
        lists:append(Acc, [{X, Y}])
    end, [], edges),
    assign_weights(N, Edges).

assign_weights(N, Edges) ->
    % Create a list of all possible weights
    Weights = lists:seq(0, N - 1),
    % Calculate the number of ways to assign weights
    count_assignments(Edges, Weights, 0).

count_assignments([], _, Count) -> 
    Count + 1;
count_assignments([{X, Y} | Rest], Weights, Count) ->
    lists:foldl(fun(W, Acc) -> 
        count_assignments(Rest, Weights, Acc + W)
    end, Count, Weights).