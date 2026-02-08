-module(min_cost_string).
-export([min_cost/1]).

min_cost(S) ->
  min_cost_helper(S, 0, 0).

min_cost_helper([], Cost, _) ->
  Cost;
min_cost_helper([H | T], Cost, Prev) ->
  case H of
    $0 ->
      case Prev of
        0 ->
          min_cost_helper(T, Cost, 0);
        1 ->
          min_cost_helper(T, Cost + 1, 0)
      end;
    $1 ->
      case Prev of
        1 ->
          min_cost_helper(T, Cost, 1);
        0 ->
          min_cost_helper(T, Cost + 1, 1)
      end
  end.