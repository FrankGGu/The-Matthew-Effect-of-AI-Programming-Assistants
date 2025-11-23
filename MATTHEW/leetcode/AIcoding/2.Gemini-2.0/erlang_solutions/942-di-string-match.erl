-module(di_string_match).
-export([di_string_match/1]).

di_string_match(S) ->
    N = length(S),
    di_string_match(S, 0, N, []).

di_string_match([], Low, High, Acc) ->
    lists:reverse([Low | Acc]);
di_string_match([$I | Rest], Low, High, Acc) ->
    di_string_match(Rest, Low + 1, High, [Low | Acc]);
di_string_match([$D | Rest], Low, High, Acc) ->
    di_string_match(Rest, Low, High - 1, [High | Acc]).