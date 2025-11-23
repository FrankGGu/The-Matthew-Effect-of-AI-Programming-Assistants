-module(shortest_unsorted_continuous_subarray).
-export([find_unsorted_subarray/1]).

find_unsorted_subarray(Nums) ->
  find_unsorted_subarray(Nums, 0, length(Nums) - 1).

find_unsorted_subarray(Nums, Start, End) ->
  case is_sorted(Nums, Start, End) of
    true ->
      0;
    false ->
      Left = find_left(Nums, Start, End),
      Right = find_right(Nums, Start, End),
      Right - Left + 1
  end.

is_sorted(Nums, Start, End) ->
  is_sorted(Nums, Start, End, true).

is_sorted(_Nums, Start, End, Acc) when Start > End ->
  Acc;
is_sorted(Nums, Start, End, Acc) ->
  case Start == End of
    true ->
      Acc;
    false ->
      case lists:nth(Start + 1, Nums) >= lists:nth(Start + 1 - 1, Nums) of
        true ->
          is_sorted(Nums, Start + 1, End, Acc);
        false ->
          false
      end
  end.

find_left(Nums, Start, End) ->
  Min = find_min_in_range(Nums, Start, End),
  find_left_index(Nums, Start, End, Min).

find_right(Nums, Start, End) ->
  Max = find_max_in_range(Nums, Start, End),
  find_right_index(Nums, Start, End, Max).

find_min_in_range(Nums, Start, End) ->
  find_min_in_range(Nums, Start, End, hd(Nums)).

find_min_in_range(Nums, Start, End, Min) when Start > End ->
  Min;
find_min_in_range(Nums, Start, End, Min) ->
  case lists:nth(Start + 1, Nums) < Min of
    true ->
      find_min_in_range(Nums, Start + 1, End, lists:nth(Start + 1, Nums));
    false ->
      find_min_in_range(Nums, Start + 1, End, Min)
  end.

find_max_in_range(Nums, Start, End) ->
  find_max_in_range(Nums, Start, End, hd(Nums)).

find_max_in_range(Nums, Start, End, Max) when Start > End ->
  Max;
find_max_in_range(Nums, Start, End, Max) ->
  case lists:nth(Start + 1, Nums) > Max of
    true ->
      find_max_in_range(Nums, Start + 1, End, lists:nth(Start + 1, Nums));
    false ->
      find_max_in_range(Nums, Start + 1, End, Max)
  end.

find_left_index(Nums, Start, End, Min) ->
  find_left_index(Nums, Start, End, Min, Start).

find_left_index(_Nums, Start, _End, _Min, Index) when Start > Index ->
  Start;
find_left_index(Nums, Start, End, Min, Index) ->
  case lists:nth(Index + 1, Nums) > Min of
    true ->
      Index;
    false ->
      find_left_index(Nums, Start, End, Min, Index - 1)
  end.

find_right_index(Nums, Start, End, Max) ->
  find_right_index(Nums, Start, End, Max, End).

find_right_index(_Nums, _Start, End, _Max, Index) when End < Index ->
  End;
find_right_index(Nums, Start, End, Max, Index) ->
  case lists:nth(Index + 1, Nums) < Max of
    true ->
      Index;
    false ->
      find_right_index(Nums, Start, End, Max, Index + 1)
  end.