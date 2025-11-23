-module(solution).
-export([max_satisfaction/1]).

-spec max_satisfaction(Satisfaction :: [integer()]) -> integer().
max_satisfaction(Satisfaction) ->
    SortedDesc = lists:reverse(lists:sort(Satisfaction)),

    {MaxLT, _, _} = lists:foldl(fun(Sat, {MaxLTAcc, CurrentSumAcc, CurrentLTAcc}) ->
                                    if CurrentSumAcc + Sat > 0 ->
                                        NewCurrentSum = CurrentSumAcc + Sat,
                                        NewCurrentLT = CurrentLTAcc + NewCurrentSum,
                                        {max(MaxLTAcc, NewCurrentLT), NewCurrentSum, NewCurrentLT};
                                    true ->
                                        {MaxLTAcc, CurrentSumAcc, CurrentLTAcc}
                                    end
                            end, {0, 0, 0}, SortedDesc),
    MaxLT.