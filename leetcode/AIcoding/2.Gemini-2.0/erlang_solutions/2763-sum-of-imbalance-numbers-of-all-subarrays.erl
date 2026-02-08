-module(sum_imbalance_numbers).
-export([sum_imbalance_numbers/1]).

sum_imbalance_numbers(Nums) ->
  sum_imbalance_numbers(Nums, 0).

sum_imbalance_numbers([], Acc) ->
  Acc;
sum_imbalance_numbers(Nums, Acc) ->
  sum_imbalance_numbers(tl(Nums), Acc + imbalance_sum(Nums)).

imbalance_sum(Nums) ->
  imbalance_sum(Nums, 0).

imbalance_sum([], Acc) ->
  Acc;
imbalance_sum(Nums, Acc) ->
  imbalance_sum(tl(Nums), Acc + imbalance(Nums)).

imbalance(Nums) ->
  imbalance(lists:sort(Nums), 0).

imbalance([_], Acc) ->
  Acc;
imbalance([H1, H2 | T], Acc) ->
  if H2 - H1 > 1 ->
    imbalance([H2 | T], Acc + 1);
  true ->
    imbalance([H2 | T], Acc)
  end.