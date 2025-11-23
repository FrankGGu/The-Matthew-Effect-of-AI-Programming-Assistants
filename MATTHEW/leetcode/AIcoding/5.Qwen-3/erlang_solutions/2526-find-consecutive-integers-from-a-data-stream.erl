-module(solution).
-export([consecutive/2]).

consecutive(Data, K) ->
    consecutive(Data, K, 1, []).

consecutive([], _, _, Acc) ->
    lists:reverse(Acc);
consecutive([H|T], K, Count, Acc) when Count == K ->
    consecutive(T, K, 1, [H | Acc]);
consecutive([H|T], K, Count, Acc) ->
    consecutive(T, K, Count + 1, Acc).