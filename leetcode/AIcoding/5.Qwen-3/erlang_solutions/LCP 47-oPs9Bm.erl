-module(solution).
-export([queue_reconstruction/1]).

queue_reconstruction(Height) ->
    Sorted = lists:sort(fun({H1, A1}, {H2, A2}) ->
        if
            H1 > H2 -> true;
            H1 == H2 -> A1 < A2;
            true -> false
        end
    end, Height),
    reconstruct(Sorted, []).

reconstruct([], Result) ->
    Result;
reconstruct([{H, A} | Rest], Result) ->
    insert({H, A}, Result, 0).

insert(Item, [], _) ->
    [Item];
insert(Item, [H | T], Count) when Count < element(2, Item) ->
    [H | insert(Item, T, Count + 1)];
insert(Item, List, _) ->
    [Item | List].