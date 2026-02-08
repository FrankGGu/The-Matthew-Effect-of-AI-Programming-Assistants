-module(solution).
-export([count_hills_and_valleys/1]).

count_hills_and_valleys(Arr) ->
    count_hills_and_valleys(Arr, 1, length(Arr), 0).

count_hills_and_valleys(_, _, N, Acc) when N < 3 ->
    Acc;
count_hills_and_valleys(Arr, I, N, Acc) ->
    A = lists:nth(I, Arr),
    B = lists:nth(I+1, Arr),
    C = lists:nth(I+2, Arr),
    if
        A > B andalso B < C -> count_hills_and_valleys(Arr, I+1, N, Acc + 1);
        A < B andalso B > C -> count_hills_and_valleys(Arr, I+1, N, Acc + 1);
        true -> count_hills_and_valleys(Arr, I+1, N, Acc)
    end.