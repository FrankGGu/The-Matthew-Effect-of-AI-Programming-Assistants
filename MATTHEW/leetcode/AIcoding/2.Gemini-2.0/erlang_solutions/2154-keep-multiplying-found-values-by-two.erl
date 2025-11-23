-module(keep_multiplying_found_values_by_two).
-export([find_final_value/2]).

find_final_value(Nums, Original) ->
  find_final_value(Nums, Original, lists:sort(Nums)).

find_final_value([], Original, _) ->
  Original;
find_final_value(_Nums, Original, []) ->
  Original;
find_final_value(Nums, Original, SortedNums) ->
  case lists:member(Original, Nums) of
    true ->
      find_final_value(Nums, Original * 2, SortedNums);
    false ->
      Original
  end.