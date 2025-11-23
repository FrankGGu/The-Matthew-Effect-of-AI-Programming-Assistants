-module(solution).
-export([building_boxes/2]).

building_boxes(N, A) ->
    lists:foldl(fun(X, Acc) -> Acc + (X div N) + (if X rem N =:= 0 -> 0; true -> 1 end) end, 0, A).