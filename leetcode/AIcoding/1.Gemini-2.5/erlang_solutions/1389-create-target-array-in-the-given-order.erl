-module(solution).
-export([create_target_array/2]).

create_target_array(Nums, Index) ->
    create_target_array_acc(Nums, Index, []).

create_target_array_acc([], [], Acc) ->
    Acc;
create_target_array_acc([Num | RestNums], [Idx | RestIdx], Acc) ->
    NewAcc = insert_at_index(Num, Idx, Acc),
    create_target_array_acc(RestNums, RestIdx, NewAcc).

insert_at_index(Element, 0, List) ->
    [Element | List];
insert_at_index(Element, N, [Head | Tail]) when N > 0 ->
    [Head | insert_at_index(Element, N - 1, Tail)].