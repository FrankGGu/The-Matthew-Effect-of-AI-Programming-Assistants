-module(minimized_maximum).
-export([minimized_maximum/2]).

minimized_maximum(N, Quantities) ->
  minimized_maximum(N, Quantities, 1, lists:max(Quantities)).

minimized_maximum(N, Quantities, Low, High) ->
  if
    Low > High ->
      High + 1;
    true ->
      Mid = (Low + High) div 2,
      StoresNeeded = lists:sum([math:ceil(Q / Mid) || Q <- Quantities]),
      if
        StoresNeeded > N ->
          minimized_maximum(N, Quantities, Mid + 1, High);
        true ->
          minimized_maximum(N, Quantities, Low, Mid - 1)
      end
  end.