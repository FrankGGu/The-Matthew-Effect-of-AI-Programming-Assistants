-module(most_frequent_even_element).
-export([most_frequent_even_element/1]).

most_frequent_even_element(Nums) ->
    EvenNums = lists:filter(fun(N) -> N rem 2 == 0 end, Nums),

    case EvenNums of
        [] ->
            -1;
        _ ->
            FreqMap = lists:foldl(
                fun(N, AccMap) ->
                    maps:update_with(N, fun(Count) -> Count + 1 end, 1, AccMap)
                end,
                maps:new(),
                EvenNums
            ),

            {_MaxFreq, Result} = maps:fold(
                fun(Num, Freq, {CurrentMaxFreq, CurrentResult}) ->
                    if
                        Freq > CurrentMaxFreq ->
                            {Freq, Num};
                        Freq == CurrentMaxFreq ->
                            {CurrentMaxFreq, min(CurrentResult, Num)};
                        true ->
                            {CurrentMaxFreq, CurrentResult}
                    end
                end,
                {0, infinity},
                FreqMap
            ),
            Result
    end.