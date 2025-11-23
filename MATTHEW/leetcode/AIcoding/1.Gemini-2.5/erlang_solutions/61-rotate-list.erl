-module(solution).
-export([rotate_right/2]).

rotate_right(Head, K) ->
    N = length(Head),
    if
        N =< 1; K == 0 ->
            Head;
        true ->
            K_eff = K rem N,
            if
                K_eff == 0 ->
                    Head;
                true ->
                    SplitPoint = N - K_eff,
                    {Prefix, Suffix} = lists:split(SplitPoint, Head),
                    Suffix ++ Prefix
            end
    end.