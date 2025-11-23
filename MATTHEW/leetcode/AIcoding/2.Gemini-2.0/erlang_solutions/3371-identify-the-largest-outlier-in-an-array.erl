-module(largest_outlier).
-export([largest_outlier/1]).

largest_outlier(Nums) ->
  {Median, SortedNums} = median_and_sorted(Nums),
  IQR = interquartile_range(SortedNums),
  LowerBound = Median - 1.5 * IQR,
  UpperBound = Median + 1.5 * IQR,
  largest_outlier(Nums, LowerBound, UpperBound, undefined).

largest_outlier([], _LowerBound, _UpperBound, Acc) ->
  Acc;
largest_outlier([H|T], LowerBound, UpperBound, Acc) ->
  if
    H < LowerBound orelse H > UpperBound ->
      NewAcc = case Acc of
        undefined -> H;
        Val -> max(Val, H)
      end,
      largest_outlier(T, LowerBound, UpperBound, NewAcc);
    true ->
      largest_outlier(T, LowerBound, UpperBound, Acc)
  end.

median_and_sorted(Nums) ->
  SortedNums = lists:sort(Nums),
  Length = length(SortedNums),
  case Length rem 2 of
    0 ->
      Middle1 = lists:nth(Length div 2, SortedNums),
      Middle2 = lists:nth((Length div 2) + 1, SortedNums),
      Median = (Middle1 + Middle2) / 2;
    1 ->
      Median = lists:nth((Length + 1) div 2, SortedNums)
  end,
  {Median, SortedNums}.

interquartile_range(SortedNums) ->
  Length = length(SortedNums),
  Q1Index = round(Length / 4),
  Q3Index = round(3 * Length / 4),
  Q1 = lists:nth(Q1Index, SortedNums),
  Q3 = lists:nth(Q3Index, SortedNums),
  Q3 - Q1.