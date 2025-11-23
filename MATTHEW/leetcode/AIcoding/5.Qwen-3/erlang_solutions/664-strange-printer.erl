-module(strange_printer).
-export([partition/1]).

partition(S) ->
    N = length(S),
    DP = array:new(N, {default, 0}),
    do_partition(S, DP, 0, N-1).

do_partition(S, DP, I, J) when I == J ->
    1;
do_partition(S, DP, I, J) ->
    Key = I * 1000 + J,
    case array:get(Key, DP) of
        V when is_integer(V) ->
            V;
        _ ->
            Min = do_partition(S, DP, I, J-1) + 1,
            Best = lists:foldl(fun K -> 
                if 
                    S ! K == S ! J ->
                        Val = do_partition(S, DP, I, K) + do_partition(S, DP, K+1, J-1),
                        min(Val, Best);
                    true ->
                        Best
                end
            end, Min, lists:seq(I, J-1)),
            array:set(Key, Best, DP),
            Best
    end.