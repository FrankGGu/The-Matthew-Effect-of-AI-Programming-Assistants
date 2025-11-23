-module(max_pairs).
-export([maximum_number_of_pairs/1]).

maximum_number_of_pairs(Nums) ->
  maximum_number_of_pairs(Nums, 0, []).

maximum_number_of_pairs([], Pairs, Remaining) ->
  {Pairs, length(Remaining)};
maximum_number_of_pairs([H|T], Pairs, Remaining) ->
  case lists:member(H, Remaining) of
    true ->
      maximum_number_of_pairs(T, Pairs + 1, lists:delete(H, Remaining));
    false ->
      maximum_number_of_pairs(T, Pairs, [H|Remaining])
  end.