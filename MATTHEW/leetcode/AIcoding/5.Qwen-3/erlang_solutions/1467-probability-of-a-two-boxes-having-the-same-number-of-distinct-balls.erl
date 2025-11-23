-module(probability).
-export([same_distinct_balls/1]).

same_distinct_balls(Balls) ->
    Total = factorial(length(Balls)),
    Count = count_ways(Balls, 0, 0),
    Count / Total.

count_ways([], _, _) -> 1;
count_ways([N | Rest], A, B) ->
    case A + B of
        _ when A + B == length(Balls) ->
            if
                A == B -> 1;
                true -> 0
            end;
        _ ->
            WaysA = count_ways(Rest, A + 1, B),
            WaysB = count_ways(Rest, A, B + 1),
            WaysA + WaysB
    end.

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).