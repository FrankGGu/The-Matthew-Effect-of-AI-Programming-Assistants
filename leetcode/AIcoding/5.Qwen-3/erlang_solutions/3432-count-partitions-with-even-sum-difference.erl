-module(solution).
-export([numWays/1]).

numWays(Nums) ->
    N = length(Nums),
    Sum = lists:sum(Nums),
    EvenSum = (Sum rem 2 == 0),
    if
        EvenSum ->
            Count = countEvenSums(Nums, 0, 0),
            Count;
        true ->
            0
    end.

countEvenSums([], _, Count) ->
    Count;
countEvenSums([H | T], Index, Count) ->
    case Index of
        0 ->
            countEvenSums(T, 1, Count + 1);
        _ ->
            NewCount = if
                (H rem 2 == 0) ->
                    Count + 1;
                true ->
                    Count
            end,
            countEvenSums(T, Index + 1, NewCount)
    end.