-module(solution).
-export([have_conflict/2]).

have_conflict([Event1Start, Event1End], [Event2Start, Event2End]) ->
    case Event1Start =< Event2End andalso Event2Start =< Event1End of
        true -> true;
        false -> false
    end.