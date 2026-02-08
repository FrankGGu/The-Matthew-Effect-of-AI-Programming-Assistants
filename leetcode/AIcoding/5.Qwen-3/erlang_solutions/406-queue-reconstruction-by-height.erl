-module(queue_reconstruction_by_height).
-export([reconstruct_queue/1]).

reconstruct_queue(Heights) ->
    Sorted = lists:sort(fun({H1, _}, {H2, _}) -> H1 >= H2 end, Heights),
    reconstruct(Sorted, []).

reconstruct([], Result) ->
    Result;
reconstruct([{H, K} | T], Result) ->
    Inserted = insert(K, {H, K}, Result),
    reconstruct(T, Inserted).

insert(0, Item, List) ->
    [Item | List];
insert(N, Item, [H | T]) ->
    [H | insert(N - 1, Item, T)].