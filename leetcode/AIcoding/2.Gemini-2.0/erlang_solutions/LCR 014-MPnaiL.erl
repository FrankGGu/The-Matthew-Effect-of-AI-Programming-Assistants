-module(permutation).
-export([check_inclusion/2]).

check_inclusion(S1, S2) ->
  Len1 = length(S1),
  Len2 = length(S2),
  if Len1 > Len2 then
    false
  else
    S1Map = create_map(S1),
    check_inclusion_helper(S1Map, S2, 0, Len1, Len2)
  end.

check_inclusion_helper(S1Map, S2, Start, Len1, Len2) ->
  if Start + Len1 > Len2 then
    false
  else
    Substr = string:substr(S2, Start + 1, Len1),
    SubstrMap = create_map(Substr),
    if S1Map == SubstrMap then
      true
    else
      check_inclusion_helper(S1Map, S2, Start + 1, Len1, Len2)
    end
  end.

create_map(String) ->
  create_map_helper(String, []).

create_map_helper([], Acc) ->
  lists:sort(Acc);
create_map_helper([H|T], Acc) ->
  create_map_helper(T, update_map(H, Acc)).

update_map(Key, []) ->
  [{Key, 1}];
update_map(Key, [{Key, Value}|Rest]) ->
  [{Key, Value + 1}|Rest];
update_map(Key, [H|T]) ->
  [H|update_map(Key, T)].