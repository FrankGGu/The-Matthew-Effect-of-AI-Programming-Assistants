-module(create_target_array).
-export([create_target_array/2]).

create_target_array(Nums, Index) ->
  create_target_array(Nums, Index, []).

create_target_array([], [], Acc) ->
  lists:reverse(Acc);
create_target_array([Num | RestNums], [Idx | RestIdx], Acc) ->
  NewAcc = insert_at(Num, Idx, Acc),
  create_target_array(RestNums, RestIdx, NewAcc).

insert_at(Val, Idx, List) ->
  insert_at(Val, Idx, List, []).

insert_at(Val, 0, List, Acc) ->
  lists:reverse(Acc) ++ [Val | List];
insert_at(Val, Idx, [H | T], Acc) ->
  insert_at(Val, Idx - 1, T, [H | Acc]);
insert_at(Val, Idx, [], Acc) ->
  lists:reverse(Acc) ++ [Val].