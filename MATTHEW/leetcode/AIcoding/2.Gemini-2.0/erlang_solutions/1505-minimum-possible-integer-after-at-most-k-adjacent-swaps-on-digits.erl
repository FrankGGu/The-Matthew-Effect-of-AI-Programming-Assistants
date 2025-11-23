-module(minimum_possible_integer).
-export([minInteger/2]).

minInteger(Num, K) ->
  Digits = string:to_integer_list(Num),
  minIntegerHelper(Digits, K, []).

minIntegerHelper([], _, Acc) ->
  lists:reverse(Acc);
minIntegerHelper(Digits, K, Acc) ->
  {MinIndex, MinDigit} = findMinDigitAndIndex(Digits, K),
  NewDigits = lists:delete_at(Digits, MinIndex + 1),
  NewK = K - MinIndex,
  minIntegerHelper(NewDigits, NewK, [MinDigit | Acc]).

findMinDigitAndIndex(Digits, K) ->
  findMinDigitAndIndexHelper(Digits, K, 0, hd(Digits), 0).

findMinDigitAndIndexHelper([], _, Index, MinDigit, MinIndex) ->
  {MinIndex, MinDigit};
findMinDigitAndIndexHelper([H | T], K, Index, MinDigit, MinIndex) ->
  if
    Index > K ->
      {MinIndex, MinDigit};
    H < MinDigit ->
      findMinDigitAndIndexHelper(T, K, Index + 1, H, Index);
    true ->
      findMinDigitAndIndexHelper(T, K, Index + 1, MinDigit, MinIndex)
  end.