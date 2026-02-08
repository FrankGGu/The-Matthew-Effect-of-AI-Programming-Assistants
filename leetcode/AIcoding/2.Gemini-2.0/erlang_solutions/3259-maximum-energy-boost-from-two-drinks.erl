-module(maximum_energy_boost).
-export([solve/1]).

solve(drinks) ->
  lists:foldl(fun(Drink, Acc) ->
                  case Drink of
                    [A, B] ->
                      Acc + (min(A, B) * 2)
                  end
                end, 0, drinks).