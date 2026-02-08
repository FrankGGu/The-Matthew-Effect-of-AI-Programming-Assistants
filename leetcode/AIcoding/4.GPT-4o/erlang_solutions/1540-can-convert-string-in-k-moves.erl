-module(solution).
-export([can_convert/3]).

can_convert(S, T, K) ->
    if
        string:length(S) =/= string:length(T) -> false;
        K < 0 -> false;
        true ->
            R = lists:foldl(fun(X, Acc) -> Acc + (if X =:= $Z -> 0; true -> 1 end) end, 0, string:to_list(S)),
            S1 = lists:map(fun(X) -> case X of $Z -> $A; _ -> X end end, string:to_list(S)),
            T1 = lists:map(fun(X) -> case X of $Z -> $A; _ -> X end end, string:to_list(T)),
            R1 = lists:foldl(fun(X, Acc) -> Acc + (if X =:= $Z -> 0; true -> 1 end) end, 0, T1),
            (K >= R + R1) andalso ((K - R - R1) rem 26 =:= 0)
    end.