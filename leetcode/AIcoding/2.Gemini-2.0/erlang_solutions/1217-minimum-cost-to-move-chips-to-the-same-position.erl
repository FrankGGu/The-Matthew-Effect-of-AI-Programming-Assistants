-module(min_cost_to_move_chips).
-export([min_cost/1]).

min_cost(Position) ->
  Odds = length([X || X <- Position, X rem 2 =:= 1]),
  Evens = length(Position) - Odds,
  min(Odds, Evens).