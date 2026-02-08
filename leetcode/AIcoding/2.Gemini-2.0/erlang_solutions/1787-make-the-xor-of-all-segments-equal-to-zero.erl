-module(solution).
-export([min_changes/1]).

min_changes(Nums) ->
  K = length(lists:nth(1, Nums)),
  solve(Nums, K).

solve(Nums, K) ->
  N = length(Nums),
  Groups = [[] || _ <- lists:seq(1, K)],
  GroupedNums = group_nums(Nums, K, Groups, 0),
  lists:foldl(
    fun(Group, Acc) ->
      Acc + min_changes_in_group(Group)
    end,
    0,
    GroupedNums
  ).

group_nums([], _K, Groups, _Idx) ->
  Groups;
group_nums([Num | Rest], K, Groups, Idx) ->
  NewIdx = (Idx rem K) + 1,
  NewGroups = lists:update_element(NewIdx, Groups, lists:append(lists:nth(NewIdx, Groups), [Num])),
  group_nums(Rest, K, NewGroups, Idx + 1).

min_changes_in_group(Group) ->
  Len = length(Group),
  if Len == 0 ->
    0
  else
    Counts = maps:from_list(lists:map(fun(X) -> {X, 1} end, Group)),
    MaxCount = lists:max(maps:values(Counts)),
    Len - MaxCount
  end.