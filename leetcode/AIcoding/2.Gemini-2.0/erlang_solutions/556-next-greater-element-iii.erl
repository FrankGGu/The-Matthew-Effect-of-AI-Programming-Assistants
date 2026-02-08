-module(next_greater_element_iii).
-export([next_greater_element/1]).

next_greater_element(N) ->
  Digits = integer_to_list(N),
  Len = length(Digits),
  case find_pivot(Digits, Len - 2) of
    none ->
      -1;
    PivotIndex ->
      {SwapIndex, _} = find_swap_index(Digits, PivotIndex),
      Digits2 = swap(Digits, PivotIndex, SwapIndex),
      Suffix = lists:sublist(Digits2, PivotIndex + 2, Len - PivotIndex - 1),
      SuffixSorted = lists:sort(Suffix),
      Prefix = lists:sublist(Digits2, 1, PivotIndex + 1),
      ResultList = Prefix ++ SuffixSorted,
      try
        list_to_integer(ResultList)
      catch
        _:_ ->
          -1
      end
  end.

find_pivot(Digits, Index) ->
  case Index < 0 of
    true ->
      none;
    false ->
      case lists:nth(Index + 1, Digits) < lists:nth(Index + 2, Digits) of
        true ->
          Index;
        false ->
          find_pivot(Digits, Index - 1)
      end
  end.

find_swap_index(Digits, PivotIndex) ->
  PivotValue = lists:nth(PivotIndex + 1, Digits),
  find_swap_index_helper(Digits, PivotIndex, length(Digits) - 1, PivotValue).

find_swap_index_helper(Digits, PivotIndex, Index, PivotValue) ->
  case Index =< PivotIndex of
    true ->
      {PivotIndex, PivotValue};
    false ->
      case lists:nth(Index + 1, Digits) > PivotValue of
        true ->
          {Index, lists:nth(Index + 1, Digits)};
        false ->
          find_swap_index_helper(Digits, PivotIndex, Index - 1, PivotValue)
      end
  end.

swap(Digits, Index1, Index2) ->
  V1 = lists:nth(Index1 + 1, Digits),
  V2 = lists:nth(Index2 + 1, Digits),
  lists:map(fun(I, V) ->
    case I of
      Index1 + 1 ->
        V2;
      Index2 + 1 ->
        V1;
      _ ->
        V
    end
           end, lists:seq(1, length(Digits)), Digits).