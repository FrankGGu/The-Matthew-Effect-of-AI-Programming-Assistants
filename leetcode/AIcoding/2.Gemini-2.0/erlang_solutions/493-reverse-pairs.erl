-module(reverse_pairs).
-export([reverse_pairs/1]).

reverse_pairs(Nums) ->
  reverse_pairs_helper(Nums, 0).

reverse_pairs_helper([], Count) ->
  Count;
reverse_pairs_helper([H | T], Count) ->
  NewCount = Count + count_reverse_pairs(H, T),
  reverse_pairs_helper(T, NewCount).

count_reverse_pairs(Num, []) ->
  0;
count_reverse_pairs(Num, [H | T]) ->
  Count = case Num > 2 * H of
            true -> 1;
            false -> 0
          end,
  Count + count_reverse_pairs(Num, T).