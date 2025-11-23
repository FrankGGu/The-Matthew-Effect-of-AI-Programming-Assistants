-module(solution).
-export([num_ways/2]).

num_ways(N, points) ->
    Ways = lists:duplicate(N + 1, 0),
    Ways = lists:sublist(Ways, 0, 1) ++ [1] ++ lists:sublist(Ways, 1, N),
    num_ways_helper(N, points, Ways).

num_ways_helper(0, _, Ways) -> 
    hd(Ways);
num_ways_helper(N, Points, Ways) -> 
    NewWays = lists:foldl(fun(P, Acc) -> 
        lists:zipwith(fun(X, Y) -> X + Y end, Acc, lists:sublist(Ways, 0, max(0, N - P + 1))) 
    end, Ways, Points),
    num_ways_helper(N - 1, Points, NewWays).