-module(find_anagrams).
-export([find_anagrams/2]).

find_anagrams(S, P) ->
  LenS = length(S),
  LenP = length(P),
  if LenP > LenS then
    []
  else
    PMap = list_to_map(P),
    find_anagrams_helper(S, PMap, LenP, 0, [])
  end.

find_anagrams_helper(S, PMap, LenP, Start, Acc) ->
  LenS = length(S),
  if Start + LenP > LenS then
    lists:reverse(Acc)
  else
    Sub = lists:sublist(S, Start + 1, LenP),
    SubMap = list_to_map(Sub),
    if SubMap =:= PMap then
      find_anagrams_helper(S, PMap, LenP, Start + 1, [Start|Acc])
    else
      find_anagrams_helper(S, PMap, LenP, Start + 1, Acc)
    end
  end.

list_to_map(List) ->
  list_to_map_helper(List, #{}).

list_to_map_helper([], Map) ->
  Map;
list_to_map_helper([H|T], Map) ->
  case maps:is_key(H, Map) of
    true ->
      Count = maps:get(H, Map),
      list_to_map_helper(T, maps:put(H, Count + 1, Map));
    false ->
      list_to_map_helper(T, maps:put(H, 1, Map))
  end.