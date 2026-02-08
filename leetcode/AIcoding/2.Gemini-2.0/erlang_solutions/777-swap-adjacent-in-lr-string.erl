-module(swap_adjacent_lr_string).
-export([can_transform/2]).

can_transform(Start, End) ->
  can_transform_helper(string:to_list(Start), string:to_list(End), []).

can_transform_helper([], [], _Acc) ->
  true;
can_transform_helper([H|T1], [H|T2], Acc) when H =:= 'X' ->
  can_transform_helper(T1, T2, Acc);
can_transform_helper([H1|T1], [H2|T2], Acc) when H1 =:= 'L', H2 =:= 'L' ->
  can_transform_helper(T1, T2, Acc);
can_transform_helper([H1|T1], [H2|T2], Acc) when H1 =:= 'R', H2 =:= 'R' ->
  can_transform_helper(T1, T2, Acc);
can_transform_helper([H1|T1], [H2|T2], Acc) when H1 =:= 'L', H2 =:= 'X' ->
  can_transform_helper(T1, [H2|T2], [H1|Acc]);
can_transform_helper([H1|T1], [H2|T2], Acc) when H1 =:= 'X', H2 =:= 'R' ->
  can_transform_helper(T1, [H2|T2], [H1|Acc]);
can_transform_helper([H1|T1], [H2|T2], Acc) when H1 =:= 'X', H2 =:= 'L', Acc =/= [] ->
  case lists:last(Acc) of
    'L' ->
      can_transform_helper(T1, [H2|T2], lists:droplast(Acc));
    _ ->
      false
  end;
can_transform_helper([H1|T1], [H2|T2], Acc) when H1 =:= 'R', H2 =:= 'X', Acc =/= [] ->
  case lists:last(Acc) of
    'R' ->
      can_transform_helper(T1, [H2|T2], lists:droplast(Acc));
    _ ->
      false
  end;
can_transform_helper(_, _, _) ->
  false.