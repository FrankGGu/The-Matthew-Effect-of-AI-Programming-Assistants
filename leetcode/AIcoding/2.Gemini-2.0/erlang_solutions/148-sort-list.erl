-module(sort_list).
-export([sort_list/1]).

sort_list(Head) ->
  to_list(Head, []) ->
    List = to_list(Head, []),
    SortedList = lists:sort(List),
    list_to_linked_list(SortedList).

to_list(Null, Acc) when Null =:= null ->
  lists:reverse(Acc);
to_list(Node, Acc) ->
  to_list(maps:get(next, Node), [maps:get(val, Node) | Acc]).

list_to_linked_list([]) ->
  null;
list_to_linked_list([H | T]) ->
  Node = #{val => H, next => list_to_linked_list(T)},
  Node.