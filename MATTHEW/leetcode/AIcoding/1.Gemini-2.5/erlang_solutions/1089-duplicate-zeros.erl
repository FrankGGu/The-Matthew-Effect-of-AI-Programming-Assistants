-module(solution).
-export([duplicate_zeros/1]).

duplicate_zeros(Arr) ->
    OriginalLength = length(Arr),
    ExpandedList = expand_zeros(Arr, []),
    take_n(ExpandedList, OriginalLength, []).

expand_zeros([], Acc) ->
    lists:reverse(Acc);
expand_zeros([0|T], Acc) ->
    expand_zeros(T, [0,0|Acc]);
expand_zeros([H|T], Acc) ->
    expand_zeros(T, [H|Acc]).

take_n(_, 0, Acc) ->
    lists:reverse(Acc);
take_n([], _, Acc) ->
    lists:reverse(Acc);
take_n([H|T], N, Acc) when N > 0 ->
    take_n(T, N-1, [H|Acc]).