-module(create_sorted_array).
-export([create_sorted_array/1]).

create_sorted_array(Instructions) ->
    create_sorted_array(Instructions, [], 0).

create_sorted_array([], _, Cost) ->
    Cost rem 1000000007;
create_sorted_array([H|T], Sorted, Cost) ->
    Less = lists:filter(fun(X) -> X < H end, Sorted),
    Greater = lists:filter(fun(X) -> X > H end, Sorted),
    LeftCost = length(Less),
    RightCost = length(Greater),
    NewCost = Cost + min(LeftCost, RightCost),
    NewSorted = insert(H, Sorted),
    create_sorted_array(T, NewSorted, NewCost).

insert(X, []) ->
    [X];
insert(X, [H|T]) ->
    if
        X < H ->
            [X, H|T];
        true ->
            [H|insert(X, T)]
    end.