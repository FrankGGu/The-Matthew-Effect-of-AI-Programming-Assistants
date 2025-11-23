-module(moving_balls).
-export([minOperations/1]).

minOperations(Balls) ->
    N = length(Balls),
    Left = lists:seq(0, N-1),
    Right = lists:reverse(lists:seq(0, N-1)),
    LeftOps = lists:foldl(fun(I, Acc) ->
        case Acc of
            [] -> [0];
            _ -> [lists:last(Acc) + lists:nth(I+1, Balls) | Acc]
        end
    end, [], Left),
    RightOps = lists:foldl(fun(I, Acc) ->
        case Acc of
            [] -> [0];
            _ -> [lists:last(Acc) + lists:nth(N-I, Balls) | Acc]
        end
    end, [], Right),
    lists:zipwith(fun(L, R) -> L + R end, lists:reverse(LeftOps), RightOps).