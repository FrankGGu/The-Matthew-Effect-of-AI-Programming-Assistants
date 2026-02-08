-module(solution).
-export([number_of_beams/1]).

number_of_beams(Bank) ->
    BeamCounts = [length( lists:filter(fun(X) -> X =/= "0" end, Row)) || Row <- Bank],
    lists:sum([BeamCounts[Index] * lists:nth(Index + 1, BeamCounts) || Index <- lists:seq(1, length(BeamCounts) - 1), BeamCounts[Index] > 0]).