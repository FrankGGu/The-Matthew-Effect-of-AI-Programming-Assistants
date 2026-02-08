-module(obstacle_course).
-export([longest_obstacle_course_at_each_position/1]).

longest_obstacle_course_at_each_position(Obstacles) ->
  length(Obstacles) - solve(Obstacles, []).

solve([], Acc) ->
  lists:reverse(Acc);
solve([H | T], Acc) ->
  solve(T, [insert(H, Acc) | Acc]).

insert(H, []) ->
  [H];
insert(H, [X | Xs]) ->
  case H >= lists:last(X) of
    true ->
      X ++ [H];
    false ->
      case lists:filter(fun(Y) -> lists:last(Y) >= H end, [X | Xs]) of
        [] ->
          [H];
        Valid ->
          MinIndex = find_min_index(H, Valid),
          lists:nth(MinIndex, [X | Xs]) -- [lists:last(lists:nth(MinIndex, [X | Xs]))],
          lists:nth(MinIndex, [X | Xs]) ++ [H]

      end
  end.

find_min_index(H, Valid) ->
  find_min_index(H, Valid, 0, length(Valid) - 1).

find_min_index(H, Valid, Low, High) ->
  case Low > High of
    true ->
      Low;
    false ->
      Mid = (Low + High) div 2,
      case lists:last(lists:nth(Mid, Valid)) >= H of
        true ->
          find_min_index(H, Valid, Low, Mid - 1);
        false ->
          find_min_index(H, Valid, Mid + 1, High)
      end
  end.