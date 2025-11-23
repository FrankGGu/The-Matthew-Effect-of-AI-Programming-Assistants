-module(reorder_list).
-export([reorderList/1]).

-spec reorderList(list()) -> list().
reorderList(List) ->
  case length(List) of
    0 -> [];
    1 -> List;
    _ ->
      {Head, Tail} = splitList(List),
      ReversedTail = reverseList(Tail),
      mergeLists(Head, ReversedTail)
  end.

splitList(List) ->
  {Half, Rest} = lists:split(length(List) div 2, List),
  {Half, Rest}.

reverseList(List) ->
  reverseListHelper(List, []).

reverseListHelper([], Acc) ->
  Acc;
reverseListHelper([H|T], Acc) ->
  reverseListHelper(T, [H|Acc]).

mergeLists([], []) ->
  [];
mergeLists([H1|T1], [H2|T2]) ->
  [H1, H2 | mergeLists(T1, T2)];
mergeLists([H1|T1], []) ->
  [H1 | mergeLists(T1, [])];
mergeLists([], [H2|T2]) ->
  [H2 | mergeLists([], T2)].