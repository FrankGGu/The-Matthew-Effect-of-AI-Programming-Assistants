-module(solution).
-export([count_pairs/2]).

count_pairs(Nums, Target) ->
  count_pairs(Nums, Target, 0, 0).

count_pairs([], _, Acc, _) ->
  Acc;
count_pairs([H | T], Target, Acc, I) ->
  Acc1 = count_less(T, Target - H, 0),
  count_pairs(T, Target, Acc + Acc1, I + 1).

count_less([], _, Acc) ->
  Acc;
count_less([H | T], Target, Acc) ->
  case H < Target of
    true -> count_less(T, Target, Acc + 1);
    false -> count_less(T, Target, Acc)
  end.