-module(solution).
-export([maxDistanceToClosestZero/1]).

maxDistanceToClosestZero(Height) ->
    N = length(Height),
    Dist = lists:duplicate(N, 0),
    Prev = -N,
    Forward = lists:seq(0, N-1),
    lists:foldl(fun(I, Acc) ->
        if
            lists:nth(I+1, Height) == 0 ->
                lists:sublist(Dist, I) ++ [0] ++ lists:sublist(Dist, I+1, N-I-1);
            true ->
                lists:sublist(Dist, I) ++ [lists:nth(I+1, Acc) + 1] ++ lists:sublist(Dist, I+1, N-I-1)
        end
    end, lists:seq(0, N-1), Forward),
    Backward = lists:reverse(lists:seq(0, N-1)),
    lists:foldl(fun(I, Acc) ->
        if
            lists:nth(I+1, Height) == 0 ->
                lists:sublist(Dist, I) ++ [0] ++ lists:sublist(Dist, I+1, N-I-1);
            true ->
                lists:sublist(Dist, I) ++ [min(lists:nth(I+1, Acc) + 1, lists:nth(I+1, Dist))] ++ lists:sublist(Dist, I+1, N-I-1)
        end
    end, Dist, Backward),
    lists:last(Dist).