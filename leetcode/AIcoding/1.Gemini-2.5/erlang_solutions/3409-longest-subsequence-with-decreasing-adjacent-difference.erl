-module(solution).
-export([longest_subsequence_with_decreasing_adjacent_difference/1]).

longest_subsequence_with_decreasing_adjacent_difference(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            {_FinalProcessedNums, _FinalDPList, MaxOverallLen} = lists:foldl(
                fun(CurrentNum, {ProcessedNums, CurrentDPListAcc, MaxOverallLenAcc}) ->
                    CurrentDPValue = lists:foldl(
                        fun({PrevNum, PrevDPValue}, MaxLenSoFar) ->
                            if
                                PrevNum > CurrentNum ->
                                    max(MaxLenSoFar, PrevDPValue + 1);
                                true ->
                                    MaxLenSoFar
                            end
                        end,
                        1,
                        lists:zip(ProcessedNums, CurrentDPListAcc)
                    ),

                    NewProcessedNums = ProcessedNums ++ [CurrentNum],
                    NewDPListAcc = CurrentDPListAcc ++ [CurrentDPValue],
                    NewMaxOverallLenAcc = max(MaxOverallLenAcc, CurrentDPValue),
                    {NewProcessedNums, NewDPListAcc, NewMaxOverallLenAcc}
                end,
                {[], [], 0},
                Nums
            ),
            MaxOverallLen
    end.