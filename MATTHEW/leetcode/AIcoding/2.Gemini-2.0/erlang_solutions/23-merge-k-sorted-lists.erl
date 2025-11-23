-module(merge_k_sorted_lists).
-export([mergeKLists/1]).

-spec mergeKLists([list()]) -> list().
mergeKLists([]) -> [];
mergeKLists([H]) -> H;
mergeKLists(Lists) ->
  merge_lists(Lists).

merge_lists(Lists) ->
  case lists:length(Lists) of
    0 -> [];
    1 -> lists:nth(1, Lists);
    _ ->
      Mid = lists:floor(lists:length(Lists) / 2),
      {L1, L2} = lists:split(Mid, Lists),
      merge(merge_lists(L1), merge_lists(L2))
  end.

merge(L1, L2) ->
  merge(L1, L2, []).

merge([], L2, Acc) ->
  lists:reverse(Acc) ++ L2;
merge(L1, [], Acc) ->
  lists:reverse(Acc) ++ L1;
merge([H1|T1], [H2|T2], Acc) ->
  case H1 =< H2 of
    true -> merge(T1, [H2|T2], [H1|Acc]);
    false -> merge([H1|T1], T2, [H2|Acc])
  end.