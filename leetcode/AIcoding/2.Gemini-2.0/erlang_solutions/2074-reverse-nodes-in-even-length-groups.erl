-module(reverse_even_length_groups).
-export([reverse_even_length_groups/1]).

-spec reverse_even_length_groups(list()) -> list().
reverse_even_length_groups(Head) ->
  reverse_even_length_groups(Head, 1, []).

reverse_even_length_groups([], _, Acc) ->
  lists:reverse(Acc);
reverse_even_length_groups(List, K, Acc) ->
  {Group, Rest} = lists:split(min(K, length(List)), List),
  case length(Group) rem 2 of
    0 ->
      reverse_even_length_groups(Rest, K + 1, Acc ++ lists:reverse(Group));
    1 ->
      reverse_even_length_groups(Rest, K + 1, Acc ++ Group)
  end.