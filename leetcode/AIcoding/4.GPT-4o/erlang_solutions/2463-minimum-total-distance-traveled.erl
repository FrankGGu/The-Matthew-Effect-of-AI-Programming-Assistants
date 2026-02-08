-module(solution).
-export([minimum_total_distance/3]).

minimum_total_distance(Cities, Locations, Fuel) ->
    N = length(Cities),
    M = length(Locations),
    Distance = lists:duplicate(N, lists:duplicate(M, 0)),
    FuelMatrix = lists:duplicate(N, lists:duplicate(M, 0)),
    calculate_distance(Cities, Locations, Distance, N, M),
    calculate_fuel(Cities, Locations, FuelMatrix, N, M),
    dp(N, M, Fuel, Distance, FuelMatrix).

calculate_distance([], _, Distance, _, _) -> Distance;
calculate_distance([City | Cities], Locations, Distance, N, M) ->
    Distance1 = calculate_distance_for_city(City, Locations, M, []),
    Distance2 = lists:map(fun(X, Y) -> lists:sublist(X, Y) end, Distance1, Distance),
    calculate_distance(Cities, Locations, Distance2, N, M).

calculate_distance_for_city(_, [], _, Acc) -> lists:reverse(Acc);
calculate_distance_for_city(City, [Location | Locations], M, Acc) ->
    Distance = abs(City - Location),
    calculate_distance_for_city(City, Locations, M, [Distance | Acc]).

calculate_fuel([], _, FuelMatrix, _, _) -> FuelMatrix;
calculate_fuel([City | Cities], Locations, FuelMatrix, N, M) ->
    FuelMatrix1 = lists:map(fun(Fuel, Location) -> abs(City - Location) <= Fuel end, FuelMatrix, Locations),
    calculate_fuel(Cities, Locations, FuelMatrix1, N, M).

dp(_, 0, _, _, _) -> 0;
dp(N, M, Fuel, Distance, FuelMatrix) ->
    dp_helper(N, M, Fuel, Distance, FuelMatrix, []).

dp_helper(_, _, Fuel, _, _) when Fuel < 0 -> infinity;
dp_helper(0, 0, _, _, _) -> 0;
dp_helper(N, M, Fuel, Distance, FuelMatrix) ->
    lists:min(lists:map(fun(X) -> if FuelMatrix(N - 1, X) -> Distance(N - 1, X) + dp_helper(N - 1, M - 1, Fuel - Distance(N - 1, X), Distance, FuelMatrix); true -> infinity end end, lists:seq(0, M - 1))).