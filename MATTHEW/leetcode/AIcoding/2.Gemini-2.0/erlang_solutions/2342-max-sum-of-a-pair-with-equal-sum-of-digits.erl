-module(max_sum_equal_digits).
-export([maximum_sum/1]).

maximum_sum(Nums) ->
  maximum_sum(Nums, #{}).

maximum_sum([], Acc) ->
  maximum_sum_helper(maps:values(Acc), -1);
maximum_sum([Num | Rest], Acc) ->
  SumDigits = sum_digits(Num),
  case maps:is_key(SumDigits, Acc) of
    true ->
      PrevNum = maps:get(SumDigits, Acc),
      NewAcc = Acc#{SumDigits => max(Num, PrevNum)},
      maximum_sum(Rest, NewAcc);
    false ->
      NewAcc = Acc#{SumDigits => Num},
      maximum_sum(Rest, NewAcc)
  end.

sum_digits(Num) ->
  sum_digits(Num, 0).

sum_digits(0, Acc) ->
  Acc;
sum_digits(Num, Acc) ->
  Digit = Num rem 10,
  sum_digits(Num div 10, Acc + Digit).

maximum_sum_helper([], Default) ->
  Default;
maximum_sum_helper([_], Default) ->
  Default;
maximum_sum_helper(Nums, Default) ->
  SortedNums = lists:sort(Nums),
  maximum_sum_helper(SortedNums, SortedNums, Default).

maximum_sum_helper([H | T], SortedNums, Acc) ->
  case T of
    [] ->
      Acc;
    [Next | Rest] ->
      maximum_sum_helper(T, SortedNums, max(Acc, H + Next))
  end.

maximum_sum_helper(Nums, SortedNums, Acc) when length(Nums) < 2 ->
    Acc.

maximum_sum_helper([H | T], SortedNums, Acc) ->
    maximum_sum_helper(T, SortedNums, max(Acc, H + lists:last(SortedNums))).