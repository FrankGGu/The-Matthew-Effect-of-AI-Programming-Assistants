-module(minimum_total_distance_traveled).
-export([minimum_totalDistance/2]).

minimum_totalDistance(Robots, Factories) ->
  RobotsSorted = lists:sort(Robots),
  FactoriesSorted = lists:sort(Factories),
  minimumTotalDistanceHelper(RobotsSorted, FactoriesSorted, []).

minimumTotalDistanceHelper([], [], Acc) ->
  sum_list(Acc);
minimumTotalDistanceHelper([], Factories, Acc) ->
  sum_list(Acc);
minimumTotalDistanceHelper(Robots, [], Acc) ->
  sum_list(Acc);
minimumTotalDistanceHelper(Robots, Factories, Acc) ->
  minimumTotalDistanceHelper(Robots, Factories, Acc, 0).

minimumTotalDistanceHelper(Robots, Factories, Acc, Index) ->
  case Index of
    0 ->
      best_distance(Robots, Factories, Acc);
    _ ->
      sum_list(Acc)
  end.

best_distance(Robots, Factories, Acc) ->
  [FirstRobot|RestRobots] = Robots,
  [FirstFactory|RestFactories] = Factories,
  {Location, Capacity} = FirstFactory,
  Distance = abs(FirstRobot - Location),
  if Capacity == 1 then
    best_distance_case1(RestRobots, RestFactories, [Distance|Acc])
  else
    best_distance_case2(Robots, Factories, Acc, FirstRobot, Location, Capacity, RestRobots, RestFactories)
  end.

best_distance_case1(RestRobots, RestFactories, Acc) ->
  minimumTotalDistanceHelper(RestRobots, RestFactories, Acc).

best_distance_case2(Robots, Factories, Acc, FirstRobot, Location, Capacity, RestRobots, RestFactories) ->
  Distance = abs(FirstRobot - Location),
  Factories2 = [{Location, Capacity - 1}|RestFactories],
  minimumTotalDistanceHelper(RestRobots, Factories2, [Distance|Acc]).

sum_list([]) -> 0;
sum_list([H|T]) -> H + sum_list(T).