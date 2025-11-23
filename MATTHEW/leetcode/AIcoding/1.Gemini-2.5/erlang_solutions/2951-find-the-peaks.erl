-module(solution).
-export([findPeaks/1]).

findPeaks(Mountains) ->
    case Mountains of
        [] -> [];
        [_] -> [];
        [_, _] -> [];
        [Prev, Current, Next | Rest] ->
            findPeaks_helper(1, Prev, Current, Next, Rest, [])
    end.

findPeaks_helper(Index, Prev, Current, Next, Rest, Acc) ->
    NewAcc = if Prev < Current andalso Current > Next -> [Index | Acc]; else -> Acc end,
    case Rest of
        [] ->
            lists:reverse(NewAcc);
        [NextNext | RestRest] ->
            findPeaks_helper(Index + 1, Current, Next, NextNext, RestRest, NewAcc)
    end.