-module(solution).
-export([min_time/2]).

min_time(A, X) ->
    N = length(A),
    {MinTime, _} = lists:foldl(fun(Ai, {Time, Acc}) ->
        NewAcc = Acc + Ai,
        NewTime = Time + 1,
        if
            NewAcc > X -> {NewTime, Acc - Ai};
            true -> {NewTime, NewAcc}
        end
    end, {0, 0}, A),
    if MinTime == N -> -1; true -> MinTime end.