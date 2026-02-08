-module(solution).
-export([shuffle/2]).

shuffle(Numbers, N) ->
    lists:flatmap(fun({X, Y}) -> [X, Y] end, lists:zip(Numbers, lists:sublist(Numbers, N)).