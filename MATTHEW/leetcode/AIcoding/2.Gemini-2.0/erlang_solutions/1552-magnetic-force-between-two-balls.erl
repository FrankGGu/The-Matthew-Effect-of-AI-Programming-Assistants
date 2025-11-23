-module(magnetic_force).
-export([max_distance/1]).

max_distance(Position) ->
  lists:sort(Position, fun(A, B) -> A < B end),
  max_distance_helper(lists:sort(Position, fun(A, B) -> A < B end), 2, 1, lists:nth(length(Position), Position) - lists:nth(1, Position)).

max_distance_helper(Position, M, Low, High) ->
  case Low > High of
    true ->
      Low - 1;
    false ->
      Mid = (Low + High) div 2,
      case can_place(Position, M, Mid) of
        true ->
          max_distance_helper(Position, M, Mid + 1, High);
        false ->
          max_distance_helper(Position, M, Low, Mid - 1)
      end
  end.

can_place(Position, M, Distance) ->
  can_place_helper(Position, M, Distance, lists:nth(1, Position), 1).

can_place_helper([], _, _, _, _) ->
  false;
can_place_helper(_Position, 1, _Distance, _LastPos, _Count) ->
  true;
can_place_helper([H | T], M, Distance, LastPos, Count) ->
  case H - LastPos >= Distance of
    true ->
      can_place_helper(T, M - 1, Distance, H, Count + 1);
    false ->
      can_place_helper(T, M, Distance, LastPos, Count)
  end.