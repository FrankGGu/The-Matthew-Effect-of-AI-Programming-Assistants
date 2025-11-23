-module(find_anagrams).
-export([find_anagrams/2]).

find_anagrams(S, P) ->
  LenS = length(S),
  LenP = length(P),
  if LenP > LenS ->
    []
  else
    PMap = build_map(P),
    find_anagrams_helper(S, PMap, LenP, 0, [])
  end.

find_anagrams_helper(S, PMap, LenP, Start, Acc) ->
  LenS = length(S),
  if Start + LenP > LenS ->
    lists:reverse(Acc)
  else
    Sub = lists:sublist(S, Start + 1, LenP),
    SubMap = build_map(Sub),
    if SubMap =:= PMap ->
      find_anagrams_helper(S, PMap, LenP, Start + 1, [Start | Acc])
    else
      find_anagrams_helper(S, PMap, LenP, Start + 1, Acc)
    end
  end.

build_map(Str) ->
  build_map_helper(Str, []).

build_map_helper([], Acc) ->
  lists:keysort(1, Acc);
build_map_helper([H|T], Acc) ->
  case lists:keyfind(H, 1, Acc) of
    false ->
      build_map_helper(T, [{H, 1} | Acc]);
    {H, Count} ->
      build_map_helper(T, lists:keyreplace(H, 1, Acc, {H, Count + 1}))
  end.