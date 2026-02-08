-module(delete_nodes_and_return_forest).
-export([del_nodes/2]).

-spec del_nodes(Root :: tree(), To_delete :: [integer()]) -> [tree()].
del_nodes(Root, To_delete) ->
  del_nodes(Root, list_to_set(To_delete), true).

del_nodes(null, _, _) ->
  [];
del_nodes({Val, Left, Right}, To_delete, Is_root) ->
  Should_delete = set_member(Val, To_delete),
  New_roots = case Should_delete of
    true ->
      Left_roots = del_nodes(Left, To_delete, true),
      Right_roots = del_nodes(Right, To_delete, true),
      Left_roots ++ Right_roots;
    false ->
      Left_roots = del_nodes(Left, To_delete, false),
      Right_roots = del_nodes(Right, To_delete, false),
      case Is_root of
        true ->
          [{Val, lists:nth(1, Left_roots), lists:nth(1, Right_roots)}];
        false ->
          [{Val, lists:nth(1, Left_roots), lists:nth(1, Right_roots)}]
      end
  end,
  case Should_delete of
    true -> New_roots;
    false ->
      case Is_root of
        true -> New_roots;
        false ->
          [update_children({Val, lists:nth(1, Left_roots), lists:nth(1, Right_roots)})]
      end
  end.

update_children({Val, Left, Right}) ->
  {Val, Left, Right}.

list_to_set(L) ->
  list_to_ordset(L).

set_member(X, Set) ->
  lists:member(X, Set).

lists:nth(1, []) ->
  null;
lists:nth(1, [X|_]) ->
  X.

-type tree() :: {integer(), tree(), tree()} | null.