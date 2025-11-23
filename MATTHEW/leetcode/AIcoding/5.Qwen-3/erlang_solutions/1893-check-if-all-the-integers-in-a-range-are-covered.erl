-module(solution).
-export([isCovered/2]).

isCovered(Covered, [Start, End]) ->
    isCovered(Covered, Start, End).

isCovered(_, _, End) when End < 0 ->
    true;
isCovered(Covered, Start, End) ->
    case lists:member(Start, Covered) of
        true -> isCovered(Covered, Start + 1, End);
        false -> false
    end.