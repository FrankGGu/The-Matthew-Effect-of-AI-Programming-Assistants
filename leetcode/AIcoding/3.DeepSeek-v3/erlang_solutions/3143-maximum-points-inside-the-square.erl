-module(solution).
-export([max_points/1]).

max_points(Points) ->
    lists:max([0 | [N || N <- lists:seq(1, 1000), check_square(Points, N)]]).

check_square(Points, S) ->
    HalfS = S / 2,
    lists:all(fun({X, Y}) -> abs(X) =< HalfS andalso abs(Y) =< HalfS end, Points).