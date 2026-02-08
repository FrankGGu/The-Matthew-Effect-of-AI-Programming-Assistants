-module(solution).
-export([get_kth/3]).

power(X) ->
    power(X, 0).

power(1, Acc) ->
    Acc;
power(X, Acc) when X rem 2 == 0 ->
    power(X div 2, Acc + 1);
power(X, Acc) ->
    power(3 * X + 1, Acc + 1).

get_kth(Lo, Hi, K) ->
    List = lists:seq(Lo, Hi),
    WithPower = lists:map(fun(X) -> {X, power(X)} end, List),
    Sorted = lists:sort(fun({_, P1}, {_, P2}) ->
                            if P1 == P2 -> 
                                element(1, P1) < element(1, P2);
                               true -> 
                                P1 < P2
                            end
                        end, WithPower),
    {Kth, _} = lists:nth(K, Sorted),
    Kth.