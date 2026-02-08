-module(solution).
-export([numSmallerByFrequency/2]).

numSmallerByFrequency(F, Q) ->
    FCounts = lists:map(fun(S) -> smallest_char_frequency(S) end, F),
    QCounts = lists:map(fun(S) -> smallest_char_frequency(S) end, Q),
    FCountsSorted = lists:sort(FCounts),
    lists:map(fun(QCount) -> length(lists:filter(fun(FCount) -> FCount < QCount end, FCountsSorted)) end, QCounts).

smallest_char_frequency(Str) ->
    CharList = lists:sort(lists:map(fun(X) -> X end, string:to_list(Str))),
    MinChar = hd(CharList),
    lists:filter(fun(X) -> X =:= MinChar end, CharList) |> length.