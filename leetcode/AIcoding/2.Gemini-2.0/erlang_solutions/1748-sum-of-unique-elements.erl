-module(sum_unique).
-export([sum_of_unique/1]).

sum_of_unique(Nums) ->
  sum_unique_helper(Nums, []).

sum_unique_helper([], Acc) ->
  lists:sum(Acc);
sum_unique_helper([H|T], Acc) ->
  case lists:member(H, T) of
    true ->
      sum_unique_helper(lists:delete(H, T), Acc);
    false ->
      case lists:member(H, Acc) of
        true ->
          sum_unique_helper(T, Acc);
        false ->
          sum_unique_helper(T, [H|Acc])
      end
  end.