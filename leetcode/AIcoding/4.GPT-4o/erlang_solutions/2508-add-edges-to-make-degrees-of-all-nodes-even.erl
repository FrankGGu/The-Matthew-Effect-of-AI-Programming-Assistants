-module(solution).
-export([add_edges/1]).

add_edges(Degrees) ->
    EvenDegrees = lists:filter(fun(X) -> X rem 2 == 0 end, Degrees),
    OddDegrees = lists:filter(fun(X) -> X rem 2 == 1 end, Degrees),
    OddCount = length(OddDegrees),
    Case = if
        OddCount == 0 -> [];
        OddCount rem 2 == 0 -> lists:duplicate(OddCount div 2, {1, 1});
        true -> lists:duplicate((OddCount div 2) + 1, {1, 1})
    end,
    Case.