-spec min_moves(nums :: [integer()], k :: integer()) -> integer().
min_moves(Nums, K) ->
    Indices = [I || {I, 1} <- lists:zip(lists:seq(0, length(Nums) - 1, Nums), 1 =:= 1],
    P = lists:sublist(Indices, length(Indices)),
    M = length(P),
    PreSum = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], P),
    PreSumRev = lists:reverse(PreSum),
    Res = lists:min([get_cost(I, I + K - 1, P, PreSumRev) || I <- lists:seq(0, M - K)]),
    Res.

get_cost(I, J, P, PreSumRev) ->
    Mid = (I + J) div 2,
    Left = Mid - I,
    Right = J - Mid,
    Cost = (P(Mid + 1) * Left - (lists:nth(Mid + 1, PreSumRev) - lists:nth(I + 1, PreSumRev))) -
           (P(Mid + 1) * Right - (lists:nth(J + 2, PreSumRev) - lists:nth(Mid + 2, PreSumRev)))),
    Cost.