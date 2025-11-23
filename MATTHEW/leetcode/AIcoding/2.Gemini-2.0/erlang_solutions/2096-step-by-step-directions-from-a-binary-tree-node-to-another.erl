-module(step_by_step).
-export([get_directions/3]).

-spec get_directions(Root :: tree(), StartValue :: integer(), DestValue :: integer()) -> string().
get_directions(Root, StartValue, DestValue) ->
  {Path1, Path2} = find_paths(Root, StartValue, DestValue),
  LCA = find_lca(Path1, Path2),
  U = lists:duplicate(length(Path1) - LCA - 1, $U),
  D = lists:reverse(lists:tl(lists:sublist(Path2, LCA + 2))),
  list_to_binary(U ++ D).

-spec find_paths(tree(), integer(), integer()) -> {list(char()), list(char())}.
find_paths(Root, StartValue, DestValue) ->
  {find_path(Root, StartValue, []), find_path(Root, DestValue, [])}.

-spec find_path(tree(), integer(), list(char())) -> list(char()).
find_path(null, _Value, _Path) ->
  [];
find_path({Value, _, _}, Value, Path) ->
  Path;
find_path({Value, Left, Right}, Target, Path) ->
  case find_path(Left, Target, Path ++ [$L]) of
    [] -> find_path(Right, Target, Path ++ [$R]);
    Path1 -> Path1
  end.

-spec find_lca(list(char()), list(char())) -> integer().
find_lca(Path1, Path2) ->
  find_lca_helper(Path1, Path2, 0).

-spec find_lca_helper(list(char()), list(char()), integer()) -> integer().
find_lca_helper([], _, Acc) ->
  Acc -1;
find_lca_helper(_, [], Acc) ->
  Acc -1;
find_lca_helper([H1|T1], [H2|T2], Acc) ->
  case H1 =:= H2 of
    true -> find_lca_helper(T1, T2, Acc + 1);
    false -> Acc - 1
  end.

-type tree() :: null | {integer(), tree(), tree()}.
-define(null, null).