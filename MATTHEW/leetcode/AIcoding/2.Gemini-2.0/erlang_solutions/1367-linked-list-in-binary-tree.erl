-module(linked_list_in_binary_tree).
-export([is_subtree/2]).

is_subtree(List, Tree) ->
  case Tree of
    null -> false;
    {_, Val, Left, Right} ->
      (starts_with(List, {Val, Left, Right})) orelse (is_subtree(List, Left)) orelse (is_subtree(List, Right))
  end.

starts_with([], _) -> true;
starts_with(_, null) -> false;
starts_with([H|T], {H, Left, Right}) -> starts_with(T, Left);
starts_with([H|_], {Val, _, _}) -> false.