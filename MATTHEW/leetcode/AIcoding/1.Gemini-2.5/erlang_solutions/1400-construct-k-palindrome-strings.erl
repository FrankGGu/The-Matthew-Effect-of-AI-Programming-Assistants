-module(solution).
-export([canConstruct/2]).

canConstruct(S, K) ->
    LenS = length(S),
    if
        K > LenS ->
            false;
        true ->
            FreqMap = lists:foldl(fun(Char, AccMap) ->
                                        maps:update_with(Char, fun(Count) -> Count + 1 end, 1, AccMap)
                                end, maps:new(), S),

            OddCount = maps:fold(fun(_Char, Count, AccOdd) ->
                                        if
                                            Count rem 2 =:= 1 -> AccOdd + 1;
                                            true -> AccOdd
                                        end
                                end, 0, FreqMap),

            OddCount =< K
    end.