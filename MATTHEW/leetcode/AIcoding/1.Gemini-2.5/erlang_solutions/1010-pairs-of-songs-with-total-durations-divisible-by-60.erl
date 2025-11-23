-module(solution).
-export([numPairsDivisibleBy60/1]).

numPairsDivisibleBy60(Time) ->
    FreqArray = array:new({size, 60}, {default, 0}),

    lists:foldl(
        fun(T, {Count, CurrentFreqArray}) ->
            Rem = T rem 60,
            ComplementRem = (60 - Rem) rem 60,

            PairsFound = array:get(ComplementRem, CurrentFreqArray),

            NewCount = Count + PairsFound,

            NewFreqArray = array:set(Rem, array:get(Rem, CurrentFreqArray) + 1, CurrentFreqArray),

            {NewCount, NewFreqArray}
        end,
        {0, FreqArray},
        Time
    )
    then fun({TotalPairs, _}) -> TotalPairs end.