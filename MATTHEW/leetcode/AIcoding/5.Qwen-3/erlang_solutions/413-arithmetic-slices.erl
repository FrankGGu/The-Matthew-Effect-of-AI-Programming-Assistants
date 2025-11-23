-module(arithmetic_slices).
-export([numberOfArithmeticSlices/1]).

numberOfArithmeticSlices(Nums) ->
    Length = length(Nums),
    if
        Length < 2 -> 0;
        true -> loop(Nums, 2, 0, 0)
    end.

loop([], _, _, Acc) -> Acc;
loop([_], _, _, Acc) -> Acc;
loop([A, B | Rest], Index, Count, Acc) ->
    if
        B - A == (lists:nth(Index, Nums) - lists:nth(Index-1, Nums)) ->
            NewCount = Count + 1,
            NewAcc = Acc + NewCount,
            loop([B | Rest], Index + 1, NewCount, NewAcc);
        true ->
            loop([B | Rest], Index + 1, 0, Acc)
    end.