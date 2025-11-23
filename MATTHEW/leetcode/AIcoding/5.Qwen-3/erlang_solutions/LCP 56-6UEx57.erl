-module(solution).
-export([transfer/1]).

transfer(Items) ->
    transfer(Items, []).

transfer([], Acc) ->
    lists:reverse(Acc);
transfer([H | T], Acc) ->
    transfer(T, [H | Acc]).