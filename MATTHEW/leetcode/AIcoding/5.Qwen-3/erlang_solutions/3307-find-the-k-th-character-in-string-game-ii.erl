-module(solution).
-export([kth_character/1]).

kth_character(N) ->
    kth_character(N, 1).

kth_character(1, K) ->
    K;
kth_character(N, K) ->
    Parent = (K + 1) div 2,
    ParentVal = kth_character(N - 1, Parent),
    if
        ParentVal == 1 ->
            2;
        true ->
            1
    end.