-module(optimal_division).
-export([optimal_division/1]).

optimal_division(Nums) ->
  optimal_division(Nums, []).

optimal_division([], Acc) ->
  string:join(lists:reverse(Acc), "/");
optimal_division([N], Acc) ->
  integer_to_list(N) ++ string:join(lists:reverse(Acc), "/");
optimal_division([First | Rest], Acc) ->
  case length(Rest) > 1 of
    true ->
      optimal_division(Rest, [")"] ++ Acc ++ ["("] ++ [integer_to_list(First)]);
    false ->
      optimal_division(Rest, [integer_to_list(First)] ++ Acc)
  end.