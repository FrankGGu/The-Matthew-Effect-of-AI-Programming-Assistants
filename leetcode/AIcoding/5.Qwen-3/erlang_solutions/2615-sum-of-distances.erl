-module(sum_of_distances).
-export([distance_sum/1]).

distance_sum(Nums) ->
    N = length(Nums),
    Dist = lists:seq(0, N-1),
    Left = left_distance(Nums, N),
    Right = right_distance(Nums, N),
    lists:zipwith(fun(L, R) -> L + R end, Left, Right).

left_distance(_, 0) -> [];
left_distance(Nums, N) ->
    [0 | left_distance(Nums, N-1, 0, 0)].

left_distance(_, 1, _, Acc) -> [Acc];
left_distance(Nums, N, I, Acc) ->
    Prev = lists:nth(I, Nums),
    Next = lists:nth(I+1, Nums),
    NewAcc = Acc + (Next - Prev),
    [NewAcc | left_distance(Nums, N-1, I+1, NewAcc)].

right_distance(_, 0) -> [];
right_distance(Nums, N) ->
    [0 | right_distance(Nums, N-1, N-1, 0)].

right_distance(_, 1, _, Acc) -> [Acc];
right_distance(Nums, N, I, Acc) ->
    Prev = lists:nth(I, Nums),
    Next = lists:nth(I-1, Nums),
    NewAcc = Acc + (Prev - Next),
    [NewAcc | right_distance(Nums, N-1, I-1, NewAcc)].