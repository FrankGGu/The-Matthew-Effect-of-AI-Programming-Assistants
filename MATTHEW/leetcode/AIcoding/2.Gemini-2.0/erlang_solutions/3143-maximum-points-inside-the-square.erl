-module(max_points_inside_square).
-export([max_points/2]).

max_points(Points, Side) ->
  max_points_helper(Points, Side, 0).

max_points_helper(Points, Side, Max) ->
  case Points of
    [] ->
      Max;
    [{X, Y} | Rest] ->
      NewMax = max(Max, max_count(X, Y, Side, Points, 0));
      max_points_helper(Rest, Side, NewMax)
  end.

max_count(X, Y, Side, Points, Count) ->
  lists:foldl(
    fun({Px, Py}, Acc) ->
      if Px >= X,
         Px <= X + Side,
         Py >= Y,
         Py <= Y + Side ->
        Acc + 1;
        true ->
          Acc
      end
    end,
    Count,
    Points
  ).