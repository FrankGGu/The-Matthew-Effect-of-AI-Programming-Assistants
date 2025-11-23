-module(beautiful_subsets).
-export([number_of_beautiful_subsets/1]).

number_of_beautiful_subsets(Nums) ->
  number_of_beautiful_subsets(Nums, []).

number_of_beautiful_subsets([], _Subset) ->
  1;
number_of_beautiful_subsets([H|T], Subset) ->
  case is_beautiful(H, Subset) of
    true ->
      number_of_beautiful_subsets(T, Subset) + number_of_beautiful_subsets(T, [H|Subset]);
    false ->
      number_of_beautiful_subsets(T, Subset)
  end.

is_beautiful(_H, []) ->
  true;
is_beautiful(H, Subset) ->
  is_beautiful(H, Subset, true).

is_beautiful(_H, [], Acc) ->
  Acc;
is_beautiful(H, [SH|ST], Acc) ->
  case abs(H - SH) == 1 of
    true ->
      false;
    false ->
      is_beautiful(H, ST, Acc)
  end.