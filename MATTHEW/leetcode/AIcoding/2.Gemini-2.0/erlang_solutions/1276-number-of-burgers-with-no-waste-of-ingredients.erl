-module(number_of_burgers).
-export([solve/2]).

solve(TomatoSlices, CheeseSlices) ->
  case solve_helper(TomatoSlices, CheeseSlices, 0, 0) of
    {ok, J, S} -> [J, S];
    error -> []
  end.

solve_helper(Tomato, Cheese, Jumbo, Small) when Tomato < 0 or Cheese < 0 ->
  error;
solve_helper(Tomato, Cheese, Jumbo, Small) when Tomato == 0 and Cheese == 0 ->
  {ok, Jumbo, Small};
solve_helper(Tomato, Cheese, Jumbo, Small) ->
  case solve_helper(Tomato - 4, Cheese - 1, Jumbo + 1, Small) of
    {ok, J, S} -> {ok, J, S};
    error ->
      solve_helper(Tomato - 2, Cheese - 1, Jumbo, Small + 1)
  end.