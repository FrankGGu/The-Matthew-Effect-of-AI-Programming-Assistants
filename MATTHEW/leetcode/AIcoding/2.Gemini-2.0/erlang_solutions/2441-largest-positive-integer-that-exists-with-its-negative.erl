-module(largest_positive_integer).
-export([find_max_k/1]).

find_max_k(Nums) ->
  Set = sets:from_list(Nums),
  find_max_k_helper(Nums, Set, -1).

find_max_k_helper([], _Set, Max) ->
  Max;
find_max_k_helper([H|T], Set, Max) ->
  Negative = -H,
  if
    sets:is_element(Negative, Set) andalso H > Max ->
      find_max_k_helper(T, Set, H);
    true ->
      find_max_k_helper(T, Set, Max)
  end.