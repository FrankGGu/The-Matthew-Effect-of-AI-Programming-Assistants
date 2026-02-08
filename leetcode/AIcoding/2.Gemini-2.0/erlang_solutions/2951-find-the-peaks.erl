-module(find_peaks).
-export([findPeaks/1]).

findPeaks(Mountain) ->
  findPeaks(Mountain, 1, length(Mountain) - 1, []).

findPeaks(Mountain, Index, End, Acc) when Index > End ->
  lists:reverse(Acc);
findPeaks(Mountain, Index, End, Acc) ->
  case is_peak(Mountain, Index) of
    true ->
      findPeaks(Mountain, Index + 1, End, [Index || Acc]);
    false ->
      findPeaks(Mountain, Index + 1, End, Acc)
  end.

is_peak(Mountain, Index) ->
  case Index of
    1 ->
      element(Index, Mountain) > element(Index + 1, Mountain);
    Length when Length == length(Mountain) ->
      element(Index, Mountain) > element(Index - 1, Mountain);
    _ ->
      element(Index, Mountain) > element(Index - 1, Mountain) andalso element(Index, Mountain) > element(Index + 1, Mountain)
  end.