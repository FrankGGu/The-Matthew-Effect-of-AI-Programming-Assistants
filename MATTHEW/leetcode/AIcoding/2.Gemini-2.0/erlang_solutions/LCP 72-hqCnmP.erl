-module(solution).
-export([supply_wagon/1]).

supply_wagon(supplies) ->
  Len = length(supplies),
  if
    Len rem 2 == 0 ->
      Mid = Len div 2,
      lists:sublist(supplies, 1, Mid) ++ lists:sublist(supplies, Mid + 1, Len - Mid);
    true ->
      Mid = (Len + 1) div 2,
      lists:sublist(supplies, 1, Mid) ++ lists:sublist(supplies, Mid + 1, Len - Mid)
  end.