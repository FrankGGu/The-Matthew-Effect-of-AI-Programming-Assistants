-module(solution).
-export([canMakeEqual/2]).

canMakeEqual(S, T) ->
    case erlang:length(S) == erlang:length(T) of
        true ->
            SBits = lists:foldl(fun(C, Acc) -> Acc + (1 bsl (C - $a)) end, 0, S),
            TBits = lists:foldl(fun(C, Acc) -> Acc + (1 bsl (C - $a)) end, 0, T),
            (SBits band TBits) == 0;
        false ->
            false
    end.