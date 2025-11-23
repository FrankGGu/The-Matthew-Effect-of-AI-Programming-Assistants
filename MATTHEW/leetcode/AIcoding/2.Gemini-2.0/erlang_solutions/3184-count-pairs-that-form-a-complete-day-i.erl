-module(count_pairs_complete_day).
-export([count_pairs/1]).

count_pairs(nums) ->
  count_pairs_helper(nums, 0).

count_pairs_helper([], Count) ->
  Count;
count_pairs_helper([H|T], Count) ->
  NewCount = Count + count_less(T, H),
  count_pairs_helper(T, NewCount).

count_less([], _) ->
  0;
count_less([H|T], Target) ->
  case H < Target of
    true -> 1 + count_less(T, Target);
    false -> count_less(T, Target)
  end.