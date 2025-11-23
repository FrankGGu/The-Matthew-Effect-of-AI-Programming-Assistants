-module(find_stable_mountains).
-export([find_indices/1]).

find_indices(Mountain) ->
  Len = length(Mountain),
  find_indices_helper(Mountain, 0, Len - 1, []).

find_indices_helper(Mountain, L, R, Acc) when L > R ->
  lists:reverse(Acc);
find_indices_helper(Mountain, L, R, Acc) ->
  if
    is_stable(Mountain, L, R) ->
      find_indices_helper(Mountain, L + 1, R, [L|Acc]);
    true ->
      find_indices_helper(Mountain, L + 1, R, Acc)
  end.

is_stable(Mountain, L, R) ->
  is_mountain(lists:sublist(Mountain, L + 1, R - L + 1)).

is_mountain(Mountain) ->
  Len = length(Mountain),
  case Len of
    0 ->
      false;
    1 ->
      true;
    _ ->
      PeakIndex = find_peak_index(Mountain),
      PeakIndex > 0 andalso PeakIndex < Len - 1 andalso
        is_increasing(lists:sublist(Mountain, 1, PeakIndex)) andalso
        is_decreasing(lists:sublist(Mountain, PeakIndex + 1, Len - PeakIndex))
  end.

find_peak_index(Mountain) ->
  find_peak_index_helper(Mountain, 0).

find_peak_index_helper(Mountain, Index) ->
  Len = length(Mountain),
  if
    Index >= Len - 1 ->
      0;
    true ->
      case Mountain of
        [H1, H2 | Rest] ->
          if
            H1 < H2 ->
              find_peak_index_helper([H2|Rest], Index + 1);
            true ->
              Index
          end;
        _ ->
          0
      end
  end.

is_increasing([]) ->
  true;
is_increasing([_]) ->
  true;
is_increasing(List) ->
  case List of
    [H1, H2 | Rest] ->
      if
        H1 < H2 ->
          is_increasing([H2|Rest]);
        true ->
          false
      end;
    _ ->
      true
  end.

is_decreasing([]) ->
  true;
is_decreasing([_]) ->
  true;
is_decreasing(List) ->
  case List of
    [H1, H2 | Rest] ->
      if
        H1 > H2 ->
          is_decreasing([H2|Rest]);
        true ->
          false
      end;
    _ ->
      true
  end.