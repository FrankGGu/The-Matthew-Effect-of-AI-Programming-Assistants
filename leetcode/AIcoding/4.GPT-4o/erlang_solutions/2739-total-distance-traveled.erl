-module(solution).
-export([distance_traveled/2]).

distance_traveled(S, D) ->
    TotalDistance = min(S * 10, D),
    RemainingDistance = D - TotalDistance,
    ExtraDistance = min(RemainingDistance, (S div 5) * 50),
    TotalDistance + ExtraDistance.