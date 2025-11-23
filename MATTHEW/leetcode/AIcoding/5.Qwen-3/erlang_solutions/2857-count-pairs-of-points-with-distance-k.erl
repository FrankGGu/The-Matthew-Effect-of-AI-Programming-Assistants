-module(solution).
-export([count_pairs/2]).

count_pairs(Points, K) ->
    Count = 0,
    Length = length(Points),
    count_pairs(Points, K, 0, Length, Count).

count_pairs(_, _, I, Length, Acc) when I >= Length ->
    Acc;
count_pairs(Points, K, I, Length, Acc) ->
    J = I + 1,
    count_pairs(Points, K, I, Length, Acc, J).

count_pairs(_, _, _, _, Acc, J) when J >= length(Points) ->
    Acc;
count_pairs(Points, K, I, Length, Acc, J) ->
    {X1, Y1} = lists:nth(I + 1, Points),
    {X2, Y2} = lists:nth(J + 1, Points),
    DX = X1 - X2,
    DY = Y1 - Y2,
    Dist = DX * DX + DY * DY,
    NewAcc = if
        Dist == K*K -> Acc + 1;
        true -> Acc
    end,
    count_pairs(Points, K, I, Length, NewAcc, J + 1).