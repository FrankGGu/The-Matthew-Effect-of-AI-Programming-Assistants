-module(solution).
-export([maximum_alloys/2]).

maximum_alloys(N, Alloy) ->
    case lists:foldl(fun({X, Y}, {Total, Min}) ->
        Total1 = Total + X div Y,
        Min1 = min(Min, X rem Y),
        {Total1, Min1}
    end, {0, hd(Alloy)}, Alloy) of
        {Total, Min} -> Total + Min
    end.