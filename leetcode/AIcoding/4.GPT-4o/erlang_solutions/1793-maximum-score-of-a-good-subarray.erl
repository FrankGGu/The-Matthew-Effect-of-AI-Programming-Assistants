-module(solution).
-export([maximum_score/3]).

maximum_score(A, L, R) ->
    Max = lists:max(A),
    MaxIndex = lists:foldl(fun(X, {Idx, MaxIdx}) ->
        if X > Max -> {Idx + 1, Idx + 1}
        else {Idx + 1, MaxIdx} end
    end, {0, -1}, A),
    {_, MaxIdx} = MaxIndex,
    {L, R} = {lists:max([L, MaxIdx]), lists:min([R, MaxIdx])},
    lists:foldl(fun(X, Acc) ->
        if X >= L andalso X =< R -> lists:max([Acc, X]);
        true -> Acc
        end
    end, 0, A).