-module(solution).
-export([minSteps/2]).

build_freq(String) ->
    lists:foldl(
        fun(Char, FreqList) ->
            Index = Char - $a,
            CurrentCount = lists:nth(Index + 1, FreqList),
            lists:replace_nth(Index + 1, CurrentCount + 1, FreqList)
        end,
        lists:duplicate(26, 0),
        String
    ).

minSteps(S, T) ->
    FreqS = build_freq(S),
    FreqT = build_freq(T),

    lists:foldl(
        fun(Index, Acc) ->
            CountS = lists:nth(Index + 1, FreqS),
            CountT = lists:nth(Index + 1, FreqT),
            Acc + max(0, CountT - CountS)
        end,
        0,
        lists:seq(0, 25)
    ).