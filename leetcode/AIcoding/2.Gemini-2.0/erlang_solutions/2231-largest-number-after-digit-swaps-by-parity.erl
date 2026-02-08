-module(largest_number_after_digit_swaps).
-export([largestInteger/1]).

largestInteger(Num) ->
  Digits = integer_to_list(Num),
  Odds = lists:sort(fun(A, B) -> A > B end, [D || D <- Digits, (D - $0) rem 2 == 1]),
  Evens = lists:sort(fun(A, B) -> A > B end, [D || D <- Digits, (D - $0) rem 2 == 0]),

  {Result, _, _} = lists:foldl(fun(Digit, {Acc, OddsIdx, EvensIdx}) ->
                                  D = Digit - $0,
                                  if D rem 2 == 1 ->
                                    {Acc * 10 + (lists:nth(OddsIdx + 1, Odds) - $0), OddsIdx + 1, EvensIdx};
                                  true ->
                                    {Acc * 10 + (lists:nth(EvensIdx + 1, Evens) - $0), OddsIdx, EvensIdx + 1}
                                  end
                                end, {0, 0, 0}, Digits),
  Result.