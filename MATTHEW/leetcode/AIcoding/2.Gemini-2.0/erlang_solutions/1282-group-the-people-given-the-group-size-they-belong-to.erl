-module(group_the_people).
-export([group_the_people/1]).

group_the_people(GroupSizes) ->
  group_the_people_helper(GroupSizes, []).

group_the_people_helper([], Acc) ->
  Acc;
group_the_people_helper(GroupSizes, Acc) ->
  group_the_people_helper_internal(GroupSizes, [], Acc).

group_the_people_helper_internal([], Current, Acc) ->
  case Current of
    [] -> Acc;
    _ -> [Current | Acc]
  end;
group_the_people_helper_internal(GroupSizes, Current, Acc) ->
  {Size, Index} = find_first_element(GroupSizes),
  NewGroupSizes = lists:delete(Size, GroupSizes),
  case length(Current) < Size of
    true ->
      NewCurrent = [Index | Current],
      if length(NewCurrent) == Size then
        group_the_people_helper_internal(NewGroupSizes, [], [NewCurrent | Acc])
      else
        group_the_people_helper_internal(NewGroupSizes, NewCurrent, Acc)
      end;
    false ->
      group_the_people_helper(NewGroupSizes, [Current | Acc])
  end.

find_first_element(List) ->
  find_first_element_helper(List, 0).

find_first_element_helper([H | T], Index) ->
  {H, Index};
find_first_element_helper([], _) ->
  erlang:error("Empty list").