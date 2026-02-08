-module(solution).
-export([beautiful_indices/2]).

beautiful_indices(Numbers, K) ->
    N = length(Numbers),
    Sorted = lists:sort([{I, Num} || {I, Num} <- lists:zip(lists:seq(0, N-1), Numbers)]),
    Result = [],
    find_beautiful(Sorted, 0, N, K, Result).

find_beautiful([], _, _, _, Acc) ->
    Acc;
find_beautiful([{I, Num} | Rest], Index, N, K, Acc) ->
    NextIndex = Index + 1,
    if
        NextIndex < N ->
            {NextI, NextNum} = lists:nth(NextIndex, Rest),
            if
                abs(Num - NextNum) >= K ->
                    find_beautiful(Rest, NextIndex, N, K, [I | Acc]);
                true ->
                    find_beautiful(Rest, NextIndex, N, K, Acc)
            end;
        true ->
            find_beautiful(Rest, NextIndex, N, K, [I | Acc])
    end.