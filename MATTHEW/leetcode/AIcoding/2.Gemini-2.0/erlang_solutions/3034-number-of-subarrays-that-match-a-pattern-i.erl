-module(number_of_subarrays_matching_pattern_i).
-export([number_of_matching_subarrays/2]).

number_of_matching_subarrays(Nums, Pattern) ->
  LenNums = length(Nums),
  LenPattern = length(Pattern),
  count_matching_subarrays(Nums, Pattern, 0, LenNums - LenPattern, 0).

count_matching_subarrays(Nums, Pattern, Start, End, Count) ->
  if Start > End then
    Count
  else
    Subarray = lists:sublist(Nums, Start + 1, length(Pattern) + 1),
    if matches_pattern(Subarray, Pattern) then
      count_matching_subarrays(Nums, Pattern, Start + 1, End, Count + 1)
    else
      count_matching_subarrays(Nums, Pattern, Start + 1, End, Count)
    end
  end.

matches_pattern(Subarray, Pattern) ->
  matches_pattern(Subarray, Pattern, 1).

matches_pattern(Subarray, Pattern, Index) ->
  case {length(Subarray), length(Pattern), Index > length(Pattern)} of
    {LenSub, LenPat, true} when LenSub == LenPat + 1 ->
      true;
    {LenSub, LenPat, _} when LenSub < LenPat + 1 ->
      false;
    {LenSub, LenPat, _} when LenSub > LenPat + 1 ->
      false;
    _ ->
      case Pattern of
        [] ->
          true;
        _ ->
          if (lists:nth(Index + 1, Subarray) > lists:nth(Index, Subarray) andalso lists:nth(Index, Pattern) == 1) orelse
             (lists:nth(Index + 1, Subarray) < lists:nth(Index, Subarray) andalso lists:nth(Index, Pattern) == 0) orelse
             (lists:nth(Index + 1, Subarray) == lists:nth(Index, Subarray) andalso lists:nth(Index, Pattern) == -1) then
            matches_pattern(Subarray, Pattern, Index + 1)
          else
            false
          end
      end
  end.