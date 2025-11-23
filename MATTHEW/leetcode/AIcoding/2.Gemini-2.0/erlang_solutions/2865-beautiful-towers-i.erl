-module(beautiful_towers_i).
-export([maximum_sum_of_heights/1]).

maximum_sum_of_heights(MaxHeights) ->
  maximum_sum_of_heights(MaxHeights, 0).

maximum_sum_of_heights([], MaxSum) ->
  MaxSum;
maximum_sum_of_heights([H|T], MaxSum) ->
  N = length([H|T]),
  PeakIndex = find_peak_index([H|T]),
  Sum = calculate_sum([H|T], PeakIndex),
  NewMaxSum = max(MaxSum, Sum),
  maximum_sum_of_heights(T, NewMaxSum).

find_peak_index(Heights) ->
  find_peak_index(Heights, 1, length(Heights)).

find_peak_index(Heights, Index, Length) ->
  find_peak_index(Heights, Index, Length, 1).

find_peak_index(Heights, Index, Length, CurrIndex) ->
  if
    CurrIndex > Length ->
      Index - 1;
    true ->
      case check_peak(Heights, CurrIndex, Length) of
        true ->
          CurrIndex;
        false ->
          find_peak_index(Heights, Index, Length, CurrIndex + 1)
      end
  end.

check_peak(Heights, Index, Length) ->
  if
    Index =:= 1 ->
      case length(Heights) of
        1 -> true;
        _ -> lists:nth(Index, Heights) >= lists:nth(Index + 1, Heights)
      end;
    Index =:= Length ->
      lists:nth(Index, Heights) >= lists:nth(Index - 1, Heights);
    true ->
      lists:nth(Index, Heights) >= lists:nth(Index - 1, Heights) and lists:nth(Index, Heights) >= lists:nth(Index + 1, Heights)
  end.

calculate_sum(Heights, PeakIndex) ->
  calculate_sum(Heights, PeakIndex, 0, 1).

calculate_sum(Heights, PeakIndex, Sum, Index) ->
  if
    Index > length(Heights) ->
      Sum;
    true ->
      Height = calculate_height(Heights, PeakIndex, Index),
      calculate_sum(Heights, PeakIndex, Sum + Height, Index + 1)
  end.

calculate_height(Heights, PeakIndex, Index) ->
  PeakHeight = lists:nth(PeakIndex, Heights),
  OriginalHeight = lists:nth(Index, Heights),
  Dist = abs(Index - PeakIndex),
  min(OriginalHeight, PeakHeight).