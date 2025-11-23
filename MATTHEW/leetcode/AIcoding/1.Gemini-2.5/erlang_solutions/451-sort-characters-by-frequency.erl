-module(solution).
-export([frequencySort/1]).

frequencySort(S) ->
    FreqMap = lists:foldl(
        fun(Char, AccMap) ->
            maps:update_with(Char, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        #{},
        S
    ),

    FreqList = lists:map(fun({Char, Count}) -> {Count, Char} end, maps:to_list(FreqMap)),

    SortedFreqList = lists:sort(
        fun({C1, Ch1}, {C2, Ch2}) ->
            if
                C1 > C2 -> true;
                C1 < C2 -> false;
                Ch1 > Ch2 -> true;
                true -> false
            end
        end,
        FreqList
    ),

    lists:foldr(
        fun({Count, Char}, AccString) ->
            lists:duplicate(Count, Char) ++ AccString
        end,
        [],
        SortedFreqList
    ).