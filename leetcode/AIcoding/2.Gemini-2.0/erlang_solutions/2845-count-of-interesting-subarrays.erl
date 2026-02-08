-module(interesting_subarrays).
-export([count_interesting_subarrays/2]).

count_interesting_subarrays(Nums, Mod) ->
  count_interesting_subarrays(Nums, Mod, 0, 0, 0, maps:new()).

count_interesting_subarrays([], _, _, Count, Result, _) ->
  Result + Count;
count_interesting_subarrays([H|T], Mod, Count, Sum, Result, Map) ->
  NewSum = (Sum + H rem Mod) rem Mod,
  NewCount = maps:get(NewSum, Map, 0),
  NewMap = maps:update_with(NewSum, fun(Old) -> Old + 1 end, 1, Map),
  case NewSum =:= 0 of
    true ->
      count_interesting_subarrays(T, Mod, Count + 1 + NewCount, NewSum, Result + Count + 1 + NewCount, NewMap);
    false ->
      count_interesting_subarrays(T, Mod, Count + NewCount, NewSum, Result + Count + NewCount, NewMap)
  end.