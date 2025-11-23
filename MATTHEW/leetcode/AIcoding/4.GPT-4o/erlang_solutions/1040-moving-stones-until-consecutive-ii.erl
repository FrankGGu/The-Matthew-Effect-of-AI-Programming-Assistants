-module(solution).
-export([numMovesStonesII/1]).

numMovesStonesII(Stones) ->
    Sorted = lists:sort(Stones),
    MinMoves = minMoves(Sorted),
    MaxMoves = maxMoves(Sorted),
    {MinMoves, MaxMoves}.

minMoves(Sorted) ->
    N = length(Sorted),
    MinMoves = case Sorted of
        [_] -> 0;
        [_ | _] -> 1;
        _ -> 
            MinGap = lists:foldl(fun(X, Acc) -> min(Acc, X) end, 1, 
                lists:zipwith(fun(A, B) -> B - A end, 
                    Sorted, tl(Sorted))),
            if
                MinGap < 2 -> 0;
                true -> 2
            end
    end,
    MinMoves + (if 
        lists:nth(1, Sorted) - lists:nth(0, Sorted) < 3 -> 1; 
        true -> 0 
    end).

maxMoves(Sorted) ->
    N = length(Sorted),
    max(0, (lists:last(Sorted) - lists:first(Sorted)) - N + 1).