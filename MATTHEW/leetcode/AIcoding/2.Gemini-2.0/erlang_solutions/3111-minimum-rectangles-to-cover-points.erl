-module(min_rectangles).
-export([solve/1]).

solve(Points) ->
  solve(Points, 0, infinity).

solve([], Count, MinCount) ->
  min(Count, MinCount);
solve([Point|Rest], Count, MinCount) ->
  case Rest of
    [] ->
      min(Count + 1, MinCount);
    _ ->
      {MinX, MinY, MaxX, MaxY} = get_bounds([Point]),
      MinCount1 = solve(Rest, Count + 1, MinCount),

      MinCount2 = solve(Rest, Count, MinCount, MinX, MinY, MaxX, MaxY, [Point])
      , min(MinCount1, MinCount2)
  end.

solve([], Count, MinCount, _, _, _, _, _) ->
  min(Count + 1, MinCount);
solve([Point|Rest], Count, MinCount, MinX0, MinY0, MaxX0, MaxY0, Acc) ->
  {X, Y} = Point,
  MinX = min(MinX0, X),
  MinY = min(MinY0, Y),
  MaxX = max(MaxX0, X),
  MaxY = max(MaxY0, Y),

  MinCount1 = solve(Rest, Count + 1, MinCount),
  MinCount2 = solve(Rest, Count, MinCount, MinX, MinY, MaxX, MaxY, [Point|Acc]),
  min(MinCount1, MinCount2).

get_bounds(Points) ->
  get_bounds(Points, hd(Points), hd(Points)).

get_bounds([], {X, Y}, {X, Y}) ->
  {X, Y, X, Y};
get_bounds([], {MinX, MinY}, {MaxX, MaxY}) ->
  {MinX, MinY, MaxX, MaxY};
get_bounds([Point|Rest], {MinX0, MinY0}, {MaxX0, MaxY0}) ->
  {X, Y} = Point,
  MinX = min(MinX0, X),
  MinY = min(MinY0, Y),
  MaxX = max(MaxX0, X),
  MaxY = max(MaxY0, Y),
  get_bounds(Rest, {MinX, MinY}, {MaxX, MaxY}).