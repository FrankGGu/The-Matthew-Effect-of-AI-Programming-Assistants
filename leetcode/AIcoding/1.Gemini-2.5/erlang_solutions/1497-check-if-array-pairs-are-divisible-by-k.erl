-module(solution).
-export([checkIfArrayPairsAreDivisibleByK/2]).

checkIfArrayPairsAreDivisibleByK(Arr, K) ->
    FreqMap = lists:foldl(fun(N, AccMap) ->
                                    Rem = (N rem K + K) rem K,
                                    maps:update_with(Rem, fun(Count) -> Count + 1 end, 1, AccMap)
                            end, maps:new(), Arr),

    Count0 = maps:get(0, FreqMap, 0),
    if
        Count0 rem 2 == 0 ->
            check_symmetric_remainders(FreqMap, K, 1);
        true ->
            false
    end.

check_symmetric_remainders(FreqMap, K, I) when I * 2 < K ->
    CountI = maps:get(I, FreqMap, 0),
    CountKMinusI = maps:get(K - I, FreqMap, 0),
    if
        CountI == CountKMinusI ->
            check_symmetric_remainders(FreqMap, K, I + 1);
        true ->
            false
    end;
check_symmetric_remainders(FreqMap, K, I) when I * 2 == K ->
    CountI = maps:get(I, FreqMap, 0),
    if
        CountI rem 2 == 0 ->
            true;
        true ->
            false
    end;
check_symmetric_remainders(_FreqMap, _K, _I) ->
    true.