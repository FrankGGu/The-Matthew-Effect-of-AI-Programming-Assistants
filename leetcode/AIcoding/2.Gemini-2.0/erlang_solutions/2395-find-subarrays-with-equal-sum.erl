-module(find_subarrays_with_equal_sum).
-export([find_subarrays::([integer()]) -> boolean()]).

find_subarrays(Nums) ->
  find_subarrays(Nums, sets:new()).

find_subarrays([], _) ->
  false;
find_subarrays([_|[]], _) ->
  false;
find_subarrays([A, B | Rest], Seen) ->
  Sum = A + B,
  case sets:is_element(Sum, Seen) of
    true ->
      true;
    false ->
      find_subarrays([B | Rest], sets:add_element(Sum, Seen))
  end.