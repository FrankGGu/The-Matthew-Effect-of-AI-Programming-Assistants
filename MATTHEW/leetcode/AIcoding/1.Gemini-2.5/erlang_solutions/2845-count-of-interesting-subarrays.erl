-module(solution).
-export([countInterestingSubarrays/3]).

countInterestingSubarrays(Nums, Modulo, K) ->
    InitialState = {0, #{0 => 1}, 0},

    {_FinalCountRelevant, _FinalMap, Ans} = lists:foldl(
        fun(Num, {CurrentCountRelevant, FreqMap, CurrentAns}) ->
            IsRelevant = (Num rem Modulo == K),

            NewCountRelevant =
                case IsRelevant of
                    true -> CurrentCountRelevant + 1;
                    false -> CurrentCountRelevant
                end,

            CurrentRemainder_K = NewCountRelevant rem K,

            TargetPrevRemainder_K = CurrentRemainder_K,

            CountFromMap = maps:get(TargetPrevRemainder_K, FreqMap, 0),

            NewAns = CurrentAns + CountFromMap,

            NewFreqMap = maps:update_counter(CurrentRemainder_K, 1, FreqMap),

            {NewCountRelevant, NewFreqMap, NewAns}
        end,
        InitialState,
        Nums
    ),
    Ans.