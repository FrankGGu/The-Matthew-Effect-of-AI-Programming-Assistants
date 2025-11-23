-module(maximum_performance).
-export([max_performance/3]).

max_performance(N, Speed, Efficiency) ->
  Speeds = lists:zip(Efficiency, Speed),
  SortedSpeeds = lists:sort(fun({E1, _}, {E2, _}) -> E1 >= E2 end, Speeds),
  max_performance_helper(SortedSpeeds, [], 0, 0, N, 0).

max_performance_helper([], _, _, _, _, MaxPerformance) ->
  MaxPerformance rem (1000000000 + 7);
max_performance_helper([{Efficiency, Speed} | Rest], Team, Sum, Count, N, MaxPerformance) ->
  NewTeam = lists:sort(fun(S1, S2) -> S1 < S2 end, [Speed | Team]),
  NewSum = Sum + Speed,
  NewCount = Count + 1,

  case NewCount > N of
    true ->
      [SmallestSpeed | _] = NewTeam,
      UpdatedTeam = lists:sublist(NewTeam, 2, N - 1),
      UpdatedSum = NewSum - SmallestSpeed,
      UpdatedCount = N,
      Performance = Efficiency * UpdatedSum,
      NewMaxPerformance = max(MaxPerformance, Performance);
    false ->
      Performance = Efficiency * NewSum,
      NewMaxPerformance = max(MaxPerformance, Performance)
  end,

  case NewCount > N of
    true ->
      [SmallestSpeed | _] = NewTeam,
      UpdatedTeam = lists:sublist(NewTeam, 2, N - 1),
      max_performance_helper(Rest, UpdatedTeam, NewSum - SmallestSpeed, N, N, NewMaxPerformance);
    false ->
      max_performance_helper(Rest, NewTeam, NewSum, NewCount, N, NewMaxPerformance)
  end.