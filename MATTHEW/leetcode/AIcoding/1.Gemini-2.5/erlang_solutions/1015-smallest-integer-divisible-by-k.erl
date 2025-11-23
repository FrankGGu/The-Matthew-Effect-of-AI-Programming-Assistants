-module(solution).
-export([smallest_repunit_divisible_by_k/1]).

smallest_repunit_divisible_by_k(K) when K == 1 -> 1;
smallest_repunit_divisible_by_k(K) when K rem 2 == 0; K rem 5 == 0 -> -1;
smallest_repunit_divisible_by_k(K) ->
    solve(K, 0, 0).

solve(K, Remainder, Length) ->
    NewRemainder = (Remainder * 10 + 1) rem K,
    NewLength = Length + 1,
    case NewRemainder of
        0 -> NewLength;
        _ -> solve(K, NewRemainder, NewLength)
    end.