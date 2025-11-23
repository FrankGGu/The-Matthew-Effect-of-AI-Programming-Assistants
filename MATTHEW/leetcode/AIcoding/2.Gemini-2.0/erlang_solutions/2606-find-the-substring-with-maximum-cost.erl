-module(find_substring_with_maximum_cost).
-export([maximum_cost_substring/2]).

maximum_cost_substring(S, Cost) ->
  maximum_cost_substring(S, Cost, 0, 0, 0).

maximum_cost_substring([], _Cost, MaxSoFar, CurrentMax, _Index) ->
  max(MaxSoFar, CurrentMax);
maximum_cost_substring([H|T], Cost, MaxSoFar, CurrentMax, Index) ->
  Char = char_to_integer(H),
  CostValue = case lists:member(Index + 97, lists:seq(97, 122)) of
                  true -> lists:nth(Char - $a + 1, Cost);
                  false -> 0
              end,
  NewCurrentMax = max(CostValue, CurrentMax + CostValue),
  NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
  maximum_cost_substring(T, Cost, NewMaxSoFar, NewCurrentMax, Index + 1).

char_to_integer(Char) ->
  Char - $a + 97.