-module(collecting_chocolates).
-export([solve/1]).

solve(chocolates) ->
  solve(chocolates, 0, 0).

solve([], Cost, NumOperations) ->
  {Cost, NumOperations};
solve(Chocolates, Cost, NumOperations) ->
  N = length(Chocolates),
  MinCost = lists:min(Chocolates),
  solve(Chocolates, Cost, NumOperations, N, MinCost).

solve(Chocolates, Cost, NumOperations, N, MinCost) ->
  solve(Chocolates, Cost, NumOperations, N, MinCost, 0).

solve(Chocolates, Cost, NumOperations, N, MinCost, Operations) ->
  case Operations > N of
    true ->
      {Cost, NumOperations};
    false ->
      case calculate_cost(Chocolates, Operations) of
        {NewChocolates, TotalCost} ->
          case TotalCost < Cost orelse Cost == 0 of
            true ->
              solve(Chocolates, TotalCost, Operations, N, MinCost, Operations + 1);
            false ->
              {Cost, NumOperations}
          end
      end
  end.

calculate_cost(Chocolates, Operations) ->
  NewChocolates = [C - Operations || C <- Chocolates],
  TotalCost = lists:sum(NewChocolates),
  {NewChocolates, TotalCost}.