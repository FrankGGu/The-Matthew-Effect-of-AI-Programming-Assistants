-module(brick_wall).
-export([least_bricks/1]).

least_bricks(Wall) ->
  least_bricks(Wall, 0, 0, []).

least_bricks([], MaxCount, _, _) ->
  lists:sum([1 || _ <- lists:flatten(Wall)]) - MaxCount;
least_bricks([Row | Rest], MaxCount, _, Acc) ->
  Counts = row_counts(Row, 0, {}),
  NewMaxCount = lists:max([MaxCount, maps:get(0, Counts, 0)]),
  least_bricks(Rest, NewMaxCount, _, Acc).

row_counts(Row, Sum, Acc) ->
  row_counts(Row, Sum, Acc, []).

row_counts([], _, Acc, _) ->
  Acc;
row_counts([Brick | Rest], Sum, Acc, _) ->
  NewSum = Sum + Brick,
  NewAcc = maps:update_with(NewSum, fun(Count) -> Count + 1 end, 1, Acc),
  row_counts(Rest, NewSum, NewAcc, _).