-module(avoid_flood).
-export([avoid_flood/1]).

avoid_flood(rains) ->
  avoid_flood(rains, [], [], []).

avoid_flood([], _, _, Acc) ->
  lists:reverse(Acc);
avoid_flood([0 | Rest], Lakes, Next, Acc) ->
  case Next of
    [] ->
      avoid_flood(Rest, Lakes, Next, [1 | Acc]);
    [L | NextRest] ->
      avoid_flood(Rest, Lakes, NextRest, [L | Acc])
  end;
avoid_flood([Lake | Rest], Lakes, Next, Acc) ->
  case lists:member(Lake, Lakes) of
    true ->
      [-1];
    false ->
      case find_next(Lake, Rest, 0) of
        {found, Index} ->
          avoid_flood(Rest, [Lake | Lakes], insert_at(Lake, Index, Next), [0 | Acc]);
        not_found ->
          [-1]
      end
  end.

find_next(Lake, [Lake | _], Index) ->
  {found, Index};
find_next(Lake, [ _ | Rest], Index) ->
  find_next(Lake, Rest, Index + 1);
find_next(_, [], _) ->
  not_found.

insert_at(Lake, Index, List) ->
  lists:sublist(List, 1, Index) ++ [Lake] ++ lists:nthtail(Index, List).