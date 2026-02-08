-module(strongest_values).
-export([k_strongest/2]).

k_strongest(Arr, K) ->
  Median = lists:nth(length(Arr) div 2 + 1, lists:sort(Arr)),
  Strongest = lists:sort(fun(A, B) ->
                                AbsA = abs(A - Median),
                                AbsB = abs(B - Median),
                                if
                                  AbsA > AbsB -> true;
                                  AbsA < AbsB -> false;
                                  true -> A > B
                                end
                            end, Arr),
  lists:sublist(lists:reverse(Strongest), 1, K).