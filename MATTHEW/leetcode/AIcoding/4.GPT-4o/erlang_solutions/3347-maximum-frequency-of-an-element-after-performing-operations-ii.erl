-module(solution).
-export([max_frequency/2]).

max_frequency(A, K) ->
    SortedA = lists:sort(A),
    max_frequency(SortedA, K, 0, 0, 0).

max_frequency(A, K, Left, Right, Sum) ->
    case Right of
        _ when Right >= length(A) -> Sum;
        _ -> 
            NewSum = Sum + lists:nth(Right + 1, A),
            NewLeft = Left,
            NewRight = Right + 1,
            if
                NewRight - NewLeft + 1 > K + lists:sum(lists:sublist(A, NewLeft + 1, NewRight - NewLeft)) -> 
                    NewLeft = NewLeft + 1
            end,
            max_frequency(A, K, NewLeft, NewRight, max(Sum, NewRight - NewLeft + 1))
    end.