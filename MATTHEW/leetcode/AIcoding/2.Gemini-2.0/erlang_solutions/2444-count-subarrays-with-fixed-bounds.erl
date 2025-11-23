-module(solution).
-export([count_subarrays/3]).

count_subarrays(Nums, MinK, MaxK) ->
  count_subarrays(Nums, MinK, MaxK, 0, 0, 0, 0).

count_subarrays([], _, _, Count, _, _, _) ->
  Count;
count_subarrays([H|T], MinK, MaxK, Count, LastMinK, LastMaxK, Start) ->
  case H >= MinK and H <= MaxK of
    true ->
      NewLastMinK = if H =:= MinK then 0 else LastMinK + 1 end,
      NewLastMaxK = if H =:= MaxK then 0 else LastMaxK + 1 end,
      NewStart = if H < MinK or H > MaxK then length(T) + 1 else Start + 1 end,
      NewCount = Count + max(0, min(NewLastMinK, NewLastMaxK) - Start + 1),
      count_subarrays(T, MinK, MaxK, NewCount, NewLastMinK, NewLastMaxK, NewStart);
    false ->
      count_subarrays(T, MinK, MaxK, Count, length(T) + 1, length(T) + 1, length(T) + 1)
  end.