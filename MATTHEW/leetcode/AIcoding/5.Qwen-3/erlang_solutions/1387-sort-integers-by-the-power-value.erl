-module(solution).
-export([sort_by_the_power_value/1]).

sort_by_the_power_value(Nums) ->
    PowerMap = maps:from_list([ {N, power(N, 0)} || N <- Nums ]),
    Sorted = lists:sort(fun(A, B) ->
                            case maps:get(A, PowerMap) of
                                PA ->
                                    case maps:get(B, PowerMap) of
                                        PB ->
                                            if PA < PB -> true;
                                               PA == PB -> A < B;
                                               true -> false
                                            end
                                    end
                            end
                        end, Nums),
    Sorted.

power(N, Count) when N == 1 ->
    Count;
power(N, Count) when N rem 2 == 0 ->
    power(N div 2, Count + 1);
power(N, Count) ->
    power(3 * N + 1, Count + 1).