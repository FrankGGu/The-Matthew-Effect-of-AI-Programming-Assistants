-module(maximum_spending).
-export([solve/1]).

solve(costs) ->
  solve(costs, 0).

solve([], Acc) ->
  Acc;
solve(Costs, Acc) ->
  {MaxIndex, MaxVal} = find_max(Costs, 0, 0, 0),
  NewAcc = Acc + MaxVal,
  NewCosts = lists:nth(MaxIndex + 1, Costs),
  NewNewCosts = lists:delete(MaxVal, NewCosts),
  NewCostsWithoutMax = lists:set_nth(MaxIndex, Costs, NewNewCosts),
  NewCostsWithoutEmpties = lists:filter(fun(L) -> length(L) > 0 end, NewCostsWithoutMax),
  solve(NewCostsWithoutEmpties, NewAcc).

find_max([H|T], Index, CurrentMaxIndex, CurrentMax) ->
  find_max(T, Index + 1, CurrentMaxIndex, CurrentMax, H);
find_max([], Index, CurrentMaxIndex, CurrentMax) ->
  {CurrentMaxIndex, CurrentMax}.

find_max([H|T], Index, CurrentMaxIndex, CurrentMax, List) ->
  Max = lists:max(List),
  if
    Max > CurrentMax ->
      find_max(T, Index + 1, Index, Max, List);
    true ->
      find_max(T, Index + 1, CurrentMaxIndex, CurrentMax, List)
  end;
find_max([], Index, CurrentMaxIndex, CurrentMax, _List) ->
  {CurrentMaxIndex, CurrentMax}.