-module(linked_list_components).
-export([num_components/2]).

num_components(Head, G) ->
  num_components(Head, sets:from_list(G), 0).

num_components(null, _, Acc) ->
  Acc;
num_components({Val, Next}, G, Acc) ->
  case sets:is_element(Val, G) of
    true ->
      case is_connected({Val, Next}, G) of
        true ->
          num_components(Next, sets:del_element(Val, G), Acc);
        false ->
          num_components(Next, sets:del_element(Val, G), Acc + 1)
      end;
    false ->
      num_components(Next, G, Acc)
  end.

is_connected(null, _) ->
  false;
is_connected({_, Next}, G) ->
  case Next of
    null ->
      false;
    {Val, _} ->
      sets:is_element(Val, G)
  end.