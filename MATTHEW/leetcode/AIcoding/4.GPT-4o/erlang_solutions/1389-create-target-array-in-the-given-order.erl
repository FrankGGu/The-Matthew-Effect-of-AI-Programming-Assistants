-module(solution).
-export([create_target_array/2]).

create_target_array(Nums, Index) ->
    create_target_array_helper(Nums, Index, [], 0).

create_target_array_helper([], [], Acc, _) ->
    lists:reverse(Acc);
create_target_array_helper([H|T], [I|J], Acc, Count) ->
    NewAcc = lists:insert_at(I, H, Acc),
    create_target_array_helper(T, J, NewAcc, Count + 1).