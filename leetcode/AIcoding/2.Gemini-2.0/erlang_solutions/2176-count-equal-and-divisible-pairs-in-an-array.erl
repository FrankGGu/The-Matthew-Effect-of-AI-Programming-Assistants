-module(solution).
-export([count_pairs/2]).

count_pairs(Nums, K) ->
  count_pairs_helper(Nums, K, 0, 0).

count_pairs_helper([], _, _, Count) ->
  Count;
count_pairs_helper([H | T], K, I, Count) ->
  NewCount = count_pairs_inner(T, K, H, I + 1, I + 1, Count),
  count_pairs_helper(T, K, I + 1, NewCount).

count_pairs_inner([], _, _, _, _, Count) ->
  Count;
count_pairs_inner([H | T], K, ValI, IndexI, IndexJ, Count) ->
  NewCount =
    case ValI =:= H andalso (IndexI * IndexJ) rem K =:= 0 of
      true -> Count + 1;
      false -> Count
    end,
  count_pairs_inner(T, K, ValI, IndexI, IndexJ + 1, NewCount).