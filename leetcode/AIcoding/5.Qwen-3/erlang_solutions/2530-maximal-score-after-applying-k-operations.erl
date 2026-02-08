-module(maximal_score_after_applying_k_operations).
-export([maximize_score/2]).

maximize_score(Numbers, K) ->
    MaxHeap = lists:reverse(lists:sort(Numbers)),
    maximize_score(MaxHeap, K, 0).

maximize_score(_, 0, Acc) ->
    Acc;
maximize_score([H | T], K, Acc) ->
    NewAcc = Acc + H,
    NewH = H div 2,
    NewHeap = insert(NewH, T),
    maximize_score(NewHeap, K - 1, NewAcc).

insert(X, []) ->
    [X];
insert(X, [H | T]) when X >= H ->
    [X, H | T];
insert(X, [H | T]) ->
    [H | insert(X, T)].