-module(solution).

-export([numberOfMatches/1]).

numberOfMatches(Teams) ->
    case Teams of
        1 -> 0;
        _ -> 
            Matches = Teams div 2,
            RemainingTeams = Teams rem 2 + Matches,
            Matches + numberOfMatches(RemainingTeams)
    end.