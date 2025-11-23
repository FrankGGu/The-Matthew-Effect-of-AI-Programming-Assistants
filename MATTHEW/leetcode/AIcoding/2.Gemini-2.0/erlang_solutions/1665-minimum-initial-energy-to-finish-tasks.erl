-module(minimum_initial_energy).
-export([minimum_effort/1]).

minimum_effort(Tasks) ->
    lists:foldl(fun({A, B}, Acc) ->
                        max(Acc + A - B, B)
                end, 0, lists:sort(fun({A1, B1}, {A2, B2}) -> B1 - A1 > B2 - A2 end, Tasks)).