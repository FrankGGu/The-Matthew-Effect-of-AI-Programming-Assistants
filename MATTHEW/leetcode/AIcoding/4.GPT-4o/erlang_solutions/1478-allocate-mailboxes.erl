-module(solution).
-export([min_distance/2]).

min_distance(Houses, K) ->
    N = length(Houses),
    Distances = lists:duplicate(N, lists:duplicate(N, 0)),
    Distances = calculate_distances(Houses, Distances),
    dp(Distances, K, N).

calculate_distances([], Distances) -> Distances;
calculate_distances([H | T], Distances) ->
    calculate_distances(T, calculate_for_house(H, T, Distances, length(Houses) - length(T) - 1)).

calculate_for_house(_, [], Distances, _) -> Distances;
calculate_for_house(House, [H | T], Distances, Index) ->
    Distance = abs(House - H),
    NewDistance = lists:nth(Index + 1, Distances) + Distance,
    NewDistances = lists:replace(Index + 1, NewDistance, Distances),
    calculate_for_house(House, T, NewDistances, Index).

dp(_, 0, _) -> 0;
dp(Distances, K, N) ->
    dp_helper(Distances, K, N, lists:duplicate(K + 1, infinity)).

dp_helper(_, 0, _, Min) -> hd(Min);
dp_helper(Distances, K, N, Min) ->
    NewMin = lists:map(fun(X) -> min(X, hd(Min)) end, tl(Min)),
    dp_helper(Distances, K-1, N-1, NewMin).