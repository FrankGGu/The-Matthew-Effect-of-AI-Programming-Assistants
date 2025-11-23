-module(solution).
-export([number_of_ways/1]).

number_of_ways(Corridor) ->
    Seats = lists:filter(fun(C) -> C =:= $S end, Corridor),
    case length(Seats) rem 2 of
        1 -> 0;
        0 ->
            case length(Seats) of
                0 -> 0;
                _ ->
                    Indices = [I || {I, C} <- lists:zip(lists:seq(0, length(Corridor) - 1), Corridor), C =:= $S],
                    Pairs = lists:zip(lists:sublist(Indices, 2, length(Indices) - 2), lists:sublist(Indices, 3, length(Indices) - 2)),
                    Gaps = [B - A || {A, B} <- Pairs],
                    lists:foldl(fun(Gap, Acc) -> (Acc * Gap) rem 1000000007 end, 1, Gaps)
            end
    end.